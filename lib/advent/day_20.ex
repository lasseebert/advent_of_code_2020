defmodule Advent.Day20 do
  @moduledoc """
  Day 20
  """

  @doc """
  Part 1
  """
  @spec part_1(String.t()) :: integer
  def part_1(input) do
    images = parse(input)
    num_images = length(images)
    big_image_size = :math.sqrt(num_images) |> trunc()

    big_image_coordinates =
      for y <- 0..(big_image_size - 1),
          x <- 0..(big_image_size - 1) do
        {x, y}
      end

    [puzzle | rest] = lay_puzzle(big_image_coordinates, %{}, images)
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
    |> Enum.flat_map(fn {found_id, _image} = piece ->
      puzzle = Map.put(puzzle, coord, piece)
      pieces = Enum.reject(pieces, fn {id, _image} -> id == found_id end)
      lay_puzzle(coords, puzzle, pieces)
    end)
  end

  defp find_matching_pieces({x, y}, puzzle, pieces) do
    left_edge =
      case Map.fetch(puzzle, {x - 1, y}) do
        {:ok, piece} -> right_edge(piece)
        :error -> nil
      end

    top_edge =
      case Map.fetch(puzzle, {x, y - 1}) do
        {:ok, piece} -> bottom_edge(piece)
        :error -> nil
      end

    pieces
    |> Enum.flat_map(&permutations/1)
    |> Enum.filter(&matching_piece?(&1, left_edge, top_edge))
  end

  defp matching_piece?(piece, left_edge, top_edge) do
    (left_edge == nil or left_edge(piece) == left_edge) and (top_edge == nil or top_edge(piece) == top_edge)
  end

  defp permutations(piece) do
    p1 = piece
    p2 = rotate(p1)
    p3 = rotate(p2)
    p4 = rotate(p3)
    p5 = flip(p1)
    p6 = rotate(p5)
    p7 = rotate(p6)
    p8 = rotate(p7)
    [p1, p2, p3, p4, p5, p6, p7, p8]
  end

  defp rotate(piece) do
    piece |> transpose() |> flip()
  end

  defp transpose({id, image}) do
    {id, Enum.map(image, fn {x, y} -> {y, x} end)}
  end

  defp flip({id, image}) do
    max_x = image |> Enum.map(&elem(&1, 0)) |> Enum.max()
    {id, Enum.map(image, fn {x, y} -> {max_x - x, y} end)}
  end

  defp right_edge({_id, image}) do
    max_x = image |> Enum.map(&elem(&1, 0)) |> Enum.max()
    image |> Enum.filter(fn {x, _y} -> x == max_x end) |> Enum.map(&elem(&1, 1)) |> Enum.sort()
  end

  defp bottom_edge({_id, image}) do
    max_y = image |> Enum.map(&elem(&1, 1)) |> Enum.max()
    image |> Enum.filter(fn {_x, y} -> y == max_y end) |> Enum.map(&elem(&1, 0)) |> Enum.sort()
  end

  defp left_edge({_id, image}) do
    image |> Enum.filter(fn {x, _y} -> x == 0 end) |> Enum.map(&elem(&1, 1)) |> Enum.sort()
  end

  defp top_edge({_id, image}) do
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
