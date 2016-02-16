# frozen_string_literal: true
require 'test_helper'

module Falling
  class NodeTest < Minitest::Test
    def setup
      Node.universe = mock_universe
    end

    def test_identifiers_are_unique
      a = Node.new
      b = Node.new
      refute_equal a.identifier, b.identifier
    end

    def test_identifiers_do_not_change
      a = Node.new
      assert_equal a.identifier, a.identifier
    end

    def test_reference
      cat_class = Class.new(Node) { reference :mother }
      mom = cat_class.new
      cat = cat_class.new
      assert_nil mom.mother
      assert_nil cat.mother
      cat.mother = mom
      assert_equal mom, cat.mother
    end

    def test_destroyed_node_references_are_nil
      cat_class = Class.new(Node) { reference :mother }
      mom = cat_class.new
      cat = cat_class.new
      cat.mother = mom
      mom.destroy!
      assert_nil cat.mother
    end

    def test_bidirectional_references
      employee_class = Class.new(Node) { reference :mentor, inverse: :student }
      mentor = employee_class.new
      student = employee_class.new
      assert_nil mentor.mentor
      assert_nil student.mentor
      assert_raises(Node::MissingInverseReferenceError) do
        student.mentor = mentor
      end
      employee_class.class_eval { reference :student, inverse: :student }
      student.mentor = mentor
      assert_equal student.mentor, mentor
      assert_equal mentor.student, student
      assert_nil student.student
      assert_nil mentor.mentor
    end

    def test_one_to_many_references
      backpack_class = Class.new(Node) { references :contents }
      item_class = Class.new(Node)
      backpack = backpack_class.new
      apple = item_class.new
      lime = item_class.new
      assert_equal Set.new, Set.new(backpack.contents)
      backpack.contents.add apple
      assert_equal Set.new([apple]), Set.new(backpack.contents)
      backpack.contents.add lime
      assert_equal Set.new([apple, lime]), Set.new(backpack.contents)
      backpack.contents.delete apple
      assert_equal Set.new([lime]), Set.new(backpack.contents)
      backpack.contents.delete lime
      assert_equal Set.new, Set.new(backpack.contents)
    end

    def test_one_to_many_missing_inverse
      boss_class = Class.new(Node) { references :minions, inverse: :boss }
      minion_class = Class.new(Node)

      boss = boss_class.new
      minion = minion_class.new

      assert_raises(Node::MissingInverseReferenceError) do
        boss.minions.add minion
      end
    end

    def test_one_to_many_inverses
      boss_class = Class.new(Node) { references :minions, inverse: :boss }
      minion_class = Class.new(Node) { reference :boss, inverse: :minions }

      boss = boss_class.new
      minion_a = minion_class.new
      minion_b = minion_class.new

      assert_equal Set.new, Set.new(boss.minions)

      boss.minions.add minion_a
      assert_equal Set.new([minion_a]), Set.new(boss.minions)
      assert_equal boss, minion_a.boss

      boss.minions.add minion_b
      assert_equal Set.new([minion_a, minion_b]), Set.new(boss.minions)
      assert_equal boss, minion_b.boss

      boss.minions.delete(minion_a)
      assert_equal Set.new([minion_b]), Set.new(boss.minions)
      assert_nil minion_a.boss

      # FIXME: Implement for basic references first.
      # minion_b.boss = nil
      # assert_equal Set.new, Set.new(boss.minions)
      # assert_nil minion_b.boss
    end

    private

    def mock_universe
      Object.new.tap do |universe|
        nodes = {}

        universe.define_singleton_method(:fetch_node) do |identifier|
          nodes[identifier]
        end

        universe.define_singleton_method(:add_node) do |node|
          nodes[node.identifier] = node
        end

        universe.define_singleton_method(:remove_node) do |node|
          nodes.delete(node.identifier)
        end
      end
    end
  end
end
