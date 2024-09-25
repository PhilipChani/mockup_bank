(() => {
  // src/js/components/report-bar-chart-1.js
  (function() {
    "use strict";
    const chartEl = $(".report-bar-chart-1");
    if (chartEl.length) {
      chartEl.each(function() {
        const ctx = $(this)[0].getContext("2d");
        const reportBarChart1 = new Chart(ctx, {
          type: "bar",
          data: {
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            datasets: [
              {
                barPercentage: 0.35,
                data: [4, 7, 5, 4, 9, 7, 5],
                borderWidth: 1,
                borderColor: getColor("primary", 0.7),
                backgroundColor: getColor("primary", 0.11)
              }
            ]
          },
          options: {
            maintainAspectRatio: false,
            plugins: {
              legend: {
                display: false
              }
            },
            scales: {
              x: {
                ticks: {
                  display: false
                },
                grid: {
                  display: false
                },
                border: {
                  display: false
                }
              },
              y: {
                ticks: {
                  display: false,
                  beginAtZero: true
                },
                grid: {
                  display: false
                },
                border: {
                  display: false
                }
              }
            }
          }
        });
        helper.watchCssVariables("html", ["color-primary"], (newValues) => {
          reportBarChart1.data.datasets[0].borderColor = getColor(
            "primary",
            0.7
          );
          reportBarChart1.data.datasets[0].backgroundColor = getColor(
            "primary",
            0.11
          );
          reportBarChart1.update();
        });
      });
    }
  })();
})();
