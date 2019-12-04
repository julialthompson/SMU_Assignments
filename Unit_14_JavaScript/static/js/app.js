// from data.js

// define what the table data is and where it comes from 
var tableData = data;
console.log(tableData);

// define tbody as the tbody 
var tbody = d3.select("tbody");


// Add all the information from data to the table 
tableData.forEach((sheepleReport) => {
    var row = tbody.append("tr");
    Object.values(sheepleReport).forEach((value) => {
        var cell = row.append("td");
        cell.text(value);
    });
});

// define our event listener as clicking button
var button = d3.select("#filter-btn");

button.on("click", function() {
    var inputValue = d3.select("#datetime").property("value");
    var inputCity = d3.select("#city").property("value").toLowerCase();


// remove all rows in the table
    d3.select("tbody").selectAll("tr").remove();

    var filteredData = tableData;
    if (inputValue !== ""){
        filteredData = tableData.filter(report => report.datetime === inputValue)
    }
    if (inputCity !== ""){
        filteredData = tableData.filter(report => report.city === inputCity);
    }
// console.log(filteredData);

    filteredData.forEach((sheepleReport) => {
        var row = tbody.append("tr");
        Object.values(sheepleReport).forEach((value) => {
            var cell = row.append("td");
            cell.text(value);
        });
    });

});

// YOUR CODE HERE!
