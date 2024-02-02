defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{
      data: data,
      left: nil,
      right: nil
    }
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{left: nil, data: node_data} = tree, data)
      when node_data >= data do
    %{
      tree
      | left: new(data)
    }
  end

  def insert(%{right: nil, data: node_data} = tree, data)
      when node_data < data do
    %{
      tree
      | right: new(data)
    }
  end

  def insert(%{left: left, data: node_data} = tree, data)
      when node_data >= data do
    %{tree | left: insert(left, data)}
  end

  def insert(%{right: right, data: node_data} = tree, data)
      when node_data < data do
    %{tree | right: insert(right, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(tree) do
    in_order(tree.left) ++ [tree.data | in_order(tree.right)]
  end
end
