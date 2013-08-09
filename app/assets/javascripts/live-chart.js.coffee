window.LiveChart = class LiveChart
  cubism: ->
    @context = cubism.context()
                     .serverDelay(1000)
                     .step(1000)
                     .size(400)

    @metric = @context.metric (start, stop, step, callback) ->
      d3.json "/api/meter_reads.json", (data) ->
        callback null, data.map (d) -> d.consumption

    console.log @metric
    d3.select("#live-chart").call (div) =>
      div.append("div")
         .attr("class", "axis")
         .call(@context.axis().orient("top"))

      div.selectAll(".horizon")
         .data([@metric])
         .enter().append("div")
         .attr("class", "horizon")
         .call(@context.horizon()
                       .height(120)
                       .format(d3.format(".2f"))
                       .title("My Usage"))

      div.append("div")
         .attr("class", "rule")
         .call(@context.rule())

    @context.on "focus", (i) ->
      console.log i
      format = d3.format(".1f")
      d3.selectAll(".horizon .value").style("right", i== null ? null : @context.size() - i + "px")
                                     .text(format(@metric.valueAt(Math.floor(i))) + "\u00B0C")

  rickshaw: ->
    new Rickshaw.Graph.Ajax( {

      element: document.getElementById("live-chart"),
      width: 235,
      height: 85,
      renderer: 'line',
      dataURL: 'data.json',
      onData: (d) -> d[0].data[0].y = 80; d
      onComplete: (transport) ->
        graph = transport.graph;
        detail = new Rickshaw.Graph.HoverDetail({ graph: graph });
      series: [
        {
          name: 'New York',
          color: '#c05020',
        }, {
          name: 'London',
          color: '#30c020',
        }, {
          name: 'Tokyo',
          color: '#6060c0'
        }
      ]
    } );

$ ->
  # new LiveChart().cubism()

