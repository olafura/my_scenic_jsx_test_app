defmodule MyScenicApp.Scene.Primitives do
  @moduledoc """
  Sample scene.
  """

  use Scenic.Scene
  alias Scenic.Graph
  import Scenic.Primitives

  alias MyScenicApp.Component.Nav
  alias MyScenicApp.Component.Notes

  require ScenicJsx
  import ScenicJsx

  @bird_hash "0DMsqJaAU2OyRdd9Hp3WWJoO3WE"
  @bird_path :code.priv_dir(:my_scenic_app)
             |> Path.join("/static/images/cyanoramphus_zealandicus_1849.jpg")

  @bird_width 100
  @bird_height 128

  @body_offset 80

  @line {{0, 0}, {60, 60}}

  @notes """
    \"Primitives\" shows the various primitives available in Scenic.
    It also shows a sampling of the styles you can apply to them.
  """

  @graph ~z(
    <font=#{:roboto} font_size=#{24}>
      <translate=#{{15, @body_offset}}>
        <text translate=#{{15, 20}}>Various primitives and styles</text>
        <t=#{{290, 50}}>
          <line stroke=#{{4, :red}}>#{@line}</line>
          <line stroke=#{{20, :green}} cap=#{:butt} t=#{{60, 0}}>#{@line}</line>
          <line stroke=#{{20, :yellow}} cap=#{:round} t=#{{120, 0}}>#{@line}</line>
        </>
        <t=#{{15, 50}}>
          <triangle fill=#{:khaki} stroke=#{{4, :green}}>#{{{0, 60}, {50, 0}, {50, 60}}}</triangle>
          <circle fill=#{:green} stroke=#{{6, :yellow}} t=#{{110, 30}}>#{30}</circle>
          <ellipse rotate=#{0.5} fill=#{:green} stroke=#{{4, :gray}} t=#{{200, 30}}>#{{30, 40}}</ellipse>
        </>
        <t=#{{15, 130}}>
          <rect fill=#{:khaki} stroke=#{{4, :green}}>#{{50,60}}</rect>
          <rrect fill=#{:green} stroke=#{{6, :yellow}} t=#{{85, 0}}>#{{50, 60, 6}}</rrect>
          <quad id=#{:quad} fill=#{{:linear, {0, 0, 400, 400, :yellow, :purple}}} stroke=#{{10, :khaki}} translate=#{{160, 0}} scale=#{0.3} pin=#{{0, 0}}>
            #{{{0, 100}, {160, 0}, {300, 110}, {200, 260}}}
          </quad>
          <sector stroke=#{{3, :grey}} fill=#{{:radial, {0, 0, 20, 160, {:yellow, 128}, {:purple, 128}}}} translate=#{{270, 70}}>
            #{{100, -0.3, -0.8}}
          </sector>
          <arc stroke=#{{6, :orange}} translate=#{{320, 70}}>#{{100, -0.1, -0.8}}</arc>
        </>
        <rect fill=#{{:image, @bird_hash}} t=#{{15, 230}}>#{{@bird_width, @bird_height}}</rect>
        <font_size=#{40} t=#{{130, 240}}>
          <text translate=#{{0, 40}}>Hello</text>
          <text translate=#{{90, 40}} fill=#{:yellow}>World</text>
          <text translate=#{{0, 80}} font_blur=#{2}>Blur</text>
          <text translate=#{{82, 82}} font_blur=#{2} fill=#{:light_grey}>Shadow</text>
          <text translate=#{{80, 80}}>Shadow</text>
        </>
        <path stroke=#{{2, :red}} translate=#{{355, 230}} rotate=#{0.5}>
          #{[
            :begin,
            {:move_to, 0, 0},
            {:bezier_to, 0, 20, 0, 50, 40, 50},
            {:bezier_to, 60, 50, 60, 20, 80, 20},
            {:bezier_to, 100, 20, 110, 0, 120, 0},
            {:bezier_to, 140, 0, 160, 30, 160, 50}
          ]}
        </path>
      </>
      <Nav>#{__MODULE__}</Nav>
      <Notes>#{@notes}</Notes>
    </>
  )

  def init(_, _opts) do
    # load the parrot texture into the cache
    Scenic.Cache.File.load(@bird_path, @bird_hash)

    push_graph(@graph)

    {:ok, @graph}
  end
end
