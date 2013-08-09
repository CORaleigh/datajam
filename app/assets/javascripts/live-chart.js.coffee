window.LiveChart = class LiveChart
  constructor: ->
    @duration = 2000
    @buildChart()
    @redraw()

  buildChart: ->
    self = this
    nv.addGraph =>
      @chart = nv.models.lineChart()
                    .x((d) -> d.date )
                    .y((d) -> d.consumption )
                    .color(d3.scale.category10().range())

      @chart.xAxis.tickFormat (d) ->
        d3.time.format('%X')(new Date(d))

      self.redraw(self.chart)
      setInterval (-> self.redraw(self.chart)), @duration

  redraw: (chart)->
    d3.json "/api/meter_reads.json", (json) =>
      values = json.map (meter_read) ->
        date: d3.time.format("%Y-%m-%dT%X.%LZ").parse(meter_read.created_at).getTime()
        consumption: meter_read.consumption
      data = [{ "key": "Usage", "values": values }]

      d3.select('#live-chart svg')
        .datum(data)
        .transition().duration(10)
        .call(chart)

      nv.utils.windowResize(chart.update)

$ ->
  window.renderedLiveChart = new LiveChart

