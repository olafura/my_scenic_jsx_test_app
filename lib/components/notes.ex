defmodule MyScenicApp.Component.Notes do
  use Scenic.Component
  require ScenicJsx
  import ScenicJsx

  alias Scenic.ViewPort

  import Scenic.Primitives, only: [{:text, 3}, {:rect, 3}]

  # import IEx

  @height 110
  @font_size 20
  @indent 30

  # --------------------------------------------------------
  def verify(notes) when is_bitstring(notes), do: {:ok, notes}
  def verify(_), do: :invalid_data

  # ----------------------------------------------------------------------------
  def init(notes, opts) do
    # Get the viewport width
    {:ok, %ViewPort.Status{size: {vp_width, vp_height}}} =
      opts[:viewport]
      |> ViewPort.info()

    graph = ~z(
        <font_size=#{@font_size} translate=#{{0, vp_height - @height}}>
          <rect fill=#{{48, 48, 48}}>#{{vp_width, @height}}</rect>
          <text translate=#{{@indent, @font_size * 2}}>#{notes}</text>
        </>
      )
      |> push_graph()

    {:ok, %{graph: graph, viewport: opts[:viewport]}}
  end
end
