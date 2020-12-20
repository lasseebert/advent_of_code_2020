defmodule Advent.Day20 do
  @moduledoc """
  Day 20
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    pieces = parse(input)
    big_image_size = pieces |> length() |> :math.sqrt() |> trunc()

    big_image_coordinates =
      for y <- 0..(big_image_size - 1),
          x <- 0..(big_image_size - 1) do
        {x, y}
      end

    # Precalc permutations of each piece for performance
    pieces =
      Enum.map(pieces, fn {id, image} ->
        permutations = permutations(image)
        {id, permutations}
      end)
      # Precalc edges of all permiutations
      |> Enum.map(fn {id, permutations} ->
        permutations =
          Enum.map(
            permutations,
            &{&1, %{top: top_edge(&1), left: left_edge(&1), bottom: bottom_edge(&1), right: right_edge(&1)}}
          )

        {id, permutations}
      end)

    [puzzle | rest] = lay_puzzle(big_image_coordinates, %{}, pieces)
    7 = length(rest)

    [{0, 0}, {0, big_image_size - 1}, {big_image_size - 1, 0}, {big_image_size - 1, big_image_size - 1}]
    |> Enum.map(&Map.fetch!(puzzle, &1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.reduce(&Kernel.*/2)
  end

  defp lay_puzzle([], puzzle, []), do: [puzzle]

  defp lay_puzzle([coord | coords], puzzle, pieces) do
    coord
    |> find_matching_pieces(puzzle, pieces)
    |> Enum.flat_map(fn {found_id, _image, _edges} = piece ->
      puzzle = Map.put(puzzle, coord, piece)
      pieces = Enum.reject(pieces, fn {id, _permutations} -> id == found_id end)
      lay_puzzle(coords, puzzle, pieces)
    end)
  end

  defp find_matching_pieces({x, y}, puzzle, pieces) do
    left_edge =
      case Map.fetch(puzzle, {x - 1, y}) do
        {:ok, {_id, _image, edges}} -> edges.right
        :error -> nil
      end

    top_edge =
      case Map.fetch(puzzle, {x, y - 1}) do
        {:ok, {_id, _image, edges}} -> edges.bottom
        :error -> nil
      end

    pieces
    |> Enum.flat_map(fn {id, permutations} ->
      Enum.map(permutations, fn {perm, edges} -> {id, perm, edges} end)
    end)
    |> Enum.filter(&matching_piece?(&1, left_edge, top_edge))
  end

  defp matching_piece?({_id, _image, edges}, left_edge, top_edge) do
    (left_edge == nil or edges.left == left_edge) and (top_edge == nil or edges.top == top_edge)
  end

  defp permutations(image) do
    i1 = image
    i2 = rotate(i1)
    i3 = rotate(i2)
    i4 = rotate(i3)
    i5 = flip(i1)
    i6 = rotate(i5)
    i7 = rotate(i6)
    i8 = rotate(i7)
    [i1, i2, i3, i4, i5, i6, i7, i8]
  end

  defp rotate(image) do
    image |> transpose() |> flip()
  end

  defp transpose(image) do
    Enum.map(image, fn {x, y} -> {y, x} end)
  end

  defp flip(image) do
    max_x = image |> Enum.map(&elem(&1, 0)) |> Enum.max()
    Enum.map(image, fn {x, y} -> {max_x - x, y} end)
  end

  defp right_edge(image) do
    max_x = image |> Enum.map(&elem(&1, 0)) |> Enum.max()
    image |> Enum.filter(fn {x, _y} -> x == max_x end) |> Enum.map(&elem(&1, 1)) |> Enum.sort()
  end

  defp bottom_edge(image) do
    max_y = image |> Enum.map(&elem(&1, 1)) |> Enum.max()
    image |> Enum.filter(fn {_x, y} -> y == max_y end) |> Enum.map(&elem(&1, 0)) |> Enum.sort()
  end

  defp left_edge(image) do
    image |> Enum.filter(fn {x, _y} -> x == 0 end) |> Enum.map(&elem(&1, 1)) |> Enum.sort()
  end

  defp top_edge(image) do
    image |> Enum.filter(fn {_x, y} -> y == 0 end) |> Enum.map(&elem(&1, 0)) |> Enum.sort()
  end

  @doc """
  Part 2
  """
  @spec part_2(String.t()) :: integer
  def part_2(input) do
    input
    |> parse()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn image ->
      [header | bmp] = String.split(image, "\n")
      tile_num = parse_header(header)
      bmp = parse_bmp(bmp)
      {tile_num, bmp}
    end)
  end

  defp parse_header(header) do
    [tile_num] = Regex.run(~r/^Tile (\d+):$/, header, capture: :all_but_first)
    String.to_integer(tile_num)
  end

  defp parse_bmp(raw) do
    raw
    |> Enum.with_index()
    |> Enum.reduce([], fn {line, y}, bmp ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _index} -> char == "#" end)
      |> Enum.reduce(bmp, fn {_char, x}, bmp -> [{x, y} | bmp] end)
    end)
  end
end
