defmodule MyScenicApp.Scene.Components do
  @moduledoc """
  Sample scene.
  """

  use Scenic.Scene
  require ScenicJsx
  import ScenicJsx
  alias MyScenicApp.Component.Nav
  alias Scenic.Graph
  import Scenic.Primitives
  import Scenic.Components

  alias MyScenicApp.Component.Nav
  alias MyScenicApp.Component.Notes

  @body_offset 60

  @notes """
    \"Components\" shows the basic components available in Scenic.
    Messages sent by the component are displayed live.
    The crash button raises an error, demonstrating how recovery works.
  """

  @graph ~z(
     <font=#{:roboto} font_size=#{24} theme=#{:dark}>
       <translate=#{{0, @body_offset + 20}}>
         <text translate=#{{15, 20}}>Various components</text>
         <text translate=#{{15, 60}} id=#{:event}>Event received:</text>
         <button id=#{:btn_crash} theme=#{:danger} t=#{{370, 0}}>Crash</button>
         <t=#{{15, 74}}>
           <translate=#{{0, 10}}>
             <button id=#{:btn_primary} theme=#{:primary}>Primary</button>
             <button id=#{:btn_success} t=#{{90, 0}} theme=#{:success}>Success</button>
             <button id=#{:btn_info} t=#{{180, 0}} theme=#{:info}>Info</button>
             <button id=#{:btn_light} t=#{{270, 0}} theme=#{:light}>Light</button>
             <button id=#{:btn_warning} t=#{{360, 0}} theme=#{:warning}>Warning</button>
             <button id=#{:btn_dark} t=#{{0, 40}} theme=#{:dark}>Dark</button>
             <button id=#{:btn_text} t=#{{90, 40}} theme=#{:text}>Text</button>
             <button id=#{:btn_danger} theme=#{:danger} t=#{{180, 40}}>Danger</button>
             <button id=#{:btn_secondary} width=#{100} t=#{{270, 40}} theme=#{:secondary}>
               Secondary
             </button>
           </>
           <slider id=#{:num_slider} t=#{{0, 95}}>#{{{0, 100}, 0}}</slider>
           <text_field width=#{240} hint="Type here" translate=#{{200, 160}}>A</text_field>
           <checkbox id=#{:check_box} t=#{{200, 140}}>#{{"Check Box", true}}</checkbox>
           <text_field id=#{:text} width=#{240} hint="Type here" translate=#{{200, 160}}>A</text_field>
           <text_field id=#{:password} width=#{240} hint="Password" translate=#{{200, 200}}>A</text_field>
           <text_field id=#{:text} width=#{240} translate=#{{200, 160}}>A</text_field>
           <text_field id=#{:password} width=#{240} translate=#{{200, 200}}>A</text_field>
           <dropdown id=#{:dropdown} translate=#{{0, 202}}>
            #{
              {
                [{"Choice 1", :choice_1}, {"Choice 2", :choice_2}, {"Choice 3", :choice_3}],
                :choice_1
              }
            }
           </dropdown>
         </>
       </>
       <Nav>#{__MODULE__}</Nav>
       <Notes>#{@notes}</Notes>
     </>
  )debug
  # <radio_group id=#{:radio_group} t=#{{0, 140}}>
  #   #{
  #      [{"Radio A", :radio_a}, {"Radio B", :radio_b, true}, {"Radio C", :radio_c, false}]
  #      # [{"Radio A", :radio_a}]
  #    }
  # </radio_group>

  @event_str "Event received: "

  # ============================================================================

  def init(_, _opts) do
    push_graph(@graph)
    {:ok, @graph}
  end

  # force the scene to crash
  def filter_event({:click, :btn_crash}, _, graph) do
    raise "The crash button was pressed. Crashing now..."
    {:stop, graph}
  end

  # display the received message
  def filter_event(event, _, graph) do
    graph =
      graph
      |> Graph.modify(:event, &text(&1, @event_str <> inspect(event)))
      |> push_graph()

    {:continue, event, graph}
  end
end
