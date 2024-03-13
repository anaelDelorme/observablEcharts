---
title: Graphiques js en Observable Framework
toc: true
---

```js
import ApexCharts from 'npm:apexcharts'
import * as echarts from "npm:echarts";
```

# Graphiques en Observable Framework   

Quelques exemples de graphiques en JS...

## ApexCharts   

Voici le graphique en ApexCharts : 

```js
//Premier Graphique qui va se mettre dans la div chart_Apex
var options = {
  chart: {
    type: 'line'
  },
  series: [{
    name: 'sales',
    data: [30,40,35,50,49,60,70,91,125]
  }],
  xaxis: {
    categories: [1991,1992,1993,1994,1995,1996,1997, 1998,1999]
  }
}

var chart = new ApexCharts(document.querySelector("#chart_Apex"), options);

chart.render();
```
<div id="chart_Apex"></div>

## echarts   

Et celui en echarts : 

```js
const myChart = echarts.init(display(html`<div style="width: 100%; height:600px;"></div>`));

      // Specify the configuration items and data for the chart
      var option = {
        title: {
          text: 'ECharts Getting Started Example'
        },
        tooltip: {},
        legend: {
          data: ['sales']
        },
        xAxis: {
          data: ['Shirts', 'Cardigans', 'Chiffons', 'Pants', 'Heels', 'Socks']
        },
        yAxis: {},
        series: [
          {
            name: 'sales',
            type: 'bar',
            data: [5, 20, 36, 10, 10, 20]
          }
        ]
      };

      // Display the chart using the configuration items and data just specified.
      myChart.setOption(option);

```