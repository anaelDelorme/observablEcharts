---
title: Heatmap en apexcharts
toc: true
---

```js
import ApexCharts from 'npm:apexcharts'
import moment from 'npm:moment'
```

```js
const epreuves = FileAttachment("epreuves.csv").csv({typed: true});
console.log("Epreuves: ", epreuves)
```

```js
var dataByDay = {};
console.log("Epreuves length: ", epreuves.length)
for (var i = 0; i < epreuves.length; i++) {
  var row = epreuves[i];
  //console.log("row: ", row)
  var date = row["Heure"].split(' ')[0];
//  console.log("row[1]: ", row[1]) 
  var hour = parseInt(row["Heure"].split(' ')[1].split(':')[0]);
  var day = date.split('-').reverse().join('-'); 
   if (hour >= 7 || hour <= 2) {
    // Si le jour n'existe pas encore dans l'objet, l'ajouter avec un tableau vide pour les heures
    if (!dataByDay[day]) {
      dataByDay[day] = new Array(20).fill(0);
    }

    // Incrémenter le compteur pour l'heure correspondante
    // Soustraire 7 à l'heure pour obtenir l'indice du tableau (de 0 à 19)
    var index = hour - 7;
    if (hour <= 2) {
      index += 17; // si l'heure est entre minuit et 2h du matin, ajouter 17 pour obtenir l'indice du tableau (de 17 à 19)
    }
    dataByDay[day][index]++;
  }
}

// Maintenant, vous pouvez utiliser les données traitées pour créer votre graphique
var options1 = {
  series: [],
  chart: {
    height: 500,
    type: 'heatmap',
  },
  dataLabels: {
    enabled: false
  },
  colors: ["#008FFB"],
  title: {
    text: 'Jeux olympiques'
  },
  xaxis: {
    categories: ['07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '00:00', '01:00', '02:00']
  },
};

var options2 = {
  series: [],
  chart: {
    height: 500,
    type: 'heatmap',
  },
  dataLabels: {
    enabled: false
  },
  colors: ["#34cb6a"],
  title: {
    text: 'Jeux paralympiques'
  },
  xaxis: {
    categories: ['07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '00:00', '01:00', '02:00']
  },
};

var days = Object.keys(dataByDay).sort(function(a, b) {
  var dateA = new Date(a.split('-').reverse().join('-'));
  var dateB = new Date(b.split('-').reverse().join('-'));
  return dateB - dateA;
});





moment.locale('fr');

var days1 = [];
var dataByDay1 = {};
var days2 = [];
var dataByDay2 = {};

for (var day in dataByDay) {
  var date = moment(day, 'DD-MM-YYYY');
  if (date >= moment('2024-07-26') && date <= moment('2024-08-12')) {
    days1.push(date.format('dddd DD/MM'));
    dataByDay1[day] = dataByDay[day];
  }
}

for (var day in dataByDay) {
  var date = moment(day, 'DD-MM-YYYY');
  if (date >= moment('2024-08-24') && date <= moment('2024-09-09')) {
    days2.push(date.format('dddd DD/MM'));
    dataByDay2[day] = dataByDay[day];
  }
}



for (var i = 0; i < days1.length; i++) {
  var day = days1[i];
  var key = moment(day, 'dddd DD/MM').format('DD-MM-YYYY'); // Récupérer la clé correspondante dans l'objet dataByDay1
  options1.series.push({
    name: day,
    data: dataByDay1[key]
  });
}

for (var i = 0; i < days2.length; i++) {
  var day = days2[i];
  var key = moment(day, 'dddd DD/MM').format('DD-MM-YYYY'); // Récupérer la clé correspondante dans l'objet dataByDay2
  options2.series.push({
    name: day,
    data: dataByDay2[key]
  });
}

var chart1 = new ApexCharts(document.querySelector("#chart1"), options1);
chart1.render();

var chart2 = new ApexCharts(document.querySelector("#chart2"), options2);
chart2.render();


```

<div id="chart1"></div>

<div id="chart2"></div>
