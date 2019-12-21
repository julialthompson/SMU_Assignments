
//set svg and chart dimensions
var svgWidth = 900;
var svgHeight = 700;
var margin = {
    top: 20,
    right: 40,
    bottom: 200,
    left: 100
};

var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

//append chart to scatter id
var chart = d3.select("#scatter")
    .append("div")
    .classed("chart", true);

//create svg wrapper
var svg = chart.append("svg")
    .attr("width", svgWidth)
    .attr("height", svgHeight);

//append svg group
var chartGroup = svg.append("g")
  .attr("transform", `translate(${margin.left}, ${margin.top})`);


//Import data from CSV
d3.csv("./assets/data/data.csv").then(function(povertydata) {

    console.log(povertydata);

    povertydata.forEach(function(data) {
        data.poverty = parseFloat(data.poverty);
        data.healthcare = parseFloat(data.healthcare);
    });

    // Create scale functions
    var xLinearScale = d3.scaleLinear()
      .domain([0, d3.max(povertydata, d => d.poverty)])
      .range([0, width]);

    var yLinearScale = d3.scaleLinear()
      .domain([0, d3.max(povertydata, d => d.healthcare)])
      .range([height, 0]);

    // Create axis functions
    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);

    // Append Axes to the chart
    chartGroup.append("g")
      .attr("transform", `translate(0, ${height})`)
      .call(bottomAxis);

    chartGroup.append("g")
      .call(leftAxis);


    //add axis labels to the chart 
    chartGroup.append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 0 - (margin.left/2))
    .attr("x", 0 - (height/2))
    .attr("dy", "1em")
    .attr("class", "aText")
    .text("Lacks Healthcare(%)");

    chartGroup.append("text")
    .attr("transform", `translate(${width / 2}, ${height + margin.top + 30})`)
    .attr("value", "poverty")
    .attr("class", "aText")
    .text("In Poverty (%)");


    // Create Circles
    var circlesGroup = chartGroup.selectAll("circle")
    .data(povertydata)
    .enter()
    .append("circle")
    .attr("class", "stateCircle")
    .attr("cx", d => xLinearScale(d.poverty))
    .attr("cy", d => yLinearScale(d.healthcare))
    .attr("r", 12)
    .attr("opacity", ".5");
    
    //create text on circles
    var textGroup = chartGroup.selectAll(".stateText")
    .data(povertydata)
    .enter()
    .append("text")
    .attr("class", "stateText")
    .attr("x", d => xLinearScale(d.poverty))
    .attr("y", d => yLinearScale(d.healthcare) + 5)
    .text(d => d.abbr)


   //Initialize tool tip
    var toolTip = d3.tip()
      .attr("class", "d3-tip")
      .offset([-8,0])
      .html(function(d) {
        return (`${d.state}<br> Poverty: ${d.poverty}<br>Healthcare: ${d.healthcare}`);
      });
    
    circlesGroup.call(toolTip);

    //add listener
    circlesGroup.on("click", function(data) {
        toolTip.show(data, this);
    })
    // onmouseout event
    .on("mouseout", function(data, index) {
        toolTip.hide(data);
    });
    textGroup.on("click", function(data) {
        toolTip.show(data, this);
    })
    // onmouseout event
    .on("mouseout", function(data, index) {
        toolTip.hide(data);
    });
    return circlesGroup, textGroup;


}).catch(function(error) {
    console.log(error);
});




