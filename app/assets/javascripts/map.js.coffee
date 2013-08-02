window.Map = class Map
  constructor: ->
    self = this
    @projection = d3.geo.albersUsa()
    path = d3.geo.path()
    @svg = d3.select("#map").append('svg')
    @markers = []

    states = @svg.append("g").attr("id", "states")
    d3.json '/us-states.json', (json) ->
      states.selectAll('path')
            .data(json.features)
            .enter()
              .append('path')
              .attr('d', path)

    self.renderDots()

  renderDots: (limit) ->
    self = this

    d3.json "/api/meter_reads.json", (data) ->
      self.markers= d3.map(data).values().map (entry) ->
        entry.coords = self.projection([entry.lon, entry.lat])
        entry

      dots = self.svg.selectAll('circle').data(self.markers, (d) -> d.id )
      dots.enter()
        .append('circle')
        .attr('r', 50)
        .attr('cx', (d) -> d.coords[0])
        .attr('cy', (d) -> d.coords[1])
        .attr('fill', (d) -> d3.rgb(93,165,102))
        .attr('opacity', .7)
        .attr('class', 'dot')
        .attr('id', (d) -> "dot-#{d.id}")
      .transition().duration(500)
        .attr('r', 5)

      dots.exit()
        .style('background-color', '#FFFF00')
        .transition().duration(3000)
        .attr('opacity', 0)
        .remove()

    setTimeout (->
      self.renderDots()), 1000

$ ->
  window.renderedMap = new Map

