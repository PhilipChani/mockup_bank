(() => {
  // src/js/components/report-line-chart-1.js
  (function() {
    "use strict";
    const chartEl = $(".report-line-chart-1");
    if (chartEl.length) {
      chartEl.each(function() {
        const ctx = $(this)[0].getContext("2d");
        const getBackground = () => {
          const canvas = document.createElement("canvas");
          const ctx2 = canvas.getContext("2d");
          const gradient = ctx2?.createLinearGradient(0, 0, 0, 400);
          gradient?.addColorStop(0, getColor("primary", 0.11));
          gradient?.addColorStop(
            1,
            $("html").hasClass("dark") ? "#28344e00" : "#ffffff01"
          );
          return gradient;
        };
        const reportLineChart1 = new Chart(ctx, {
          type: "line",
          data: {
            labels: [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec"
            ],
            datasets: [
              {
                data: [
                  0,
                  350,
                  250,
                  200,
                  500,
                  450,
                  850,
                  1050,
                  950,
                  1100,
                  900,
                  1200
                ],
                borderWidth: 1,
                borderColor: getColor("primary", 0.7),
                pointRadius: 3.5,
                pointBorderColor: getColor("primary", 0.7),
                pointBackgroundColor: $("html").hasClass("dark") ? getColor("darkmode.400") : "#ffffff",
                backgroundColor: getBackground(),
                tension: 0.3,
                fill: true
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
                  font: {
                    size: 12
                  },
                  color: getColor("slate.500", 0.8)
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
                  font: {
                    size: 12
                  },
                  color: getColor("slate.500", 0.8),
                  callback: function(value, index, values) {
                    return "$" + value;
                  }
                },
                grid: {
                  color: $("html").hasClass("dark") ? getColor("slate.500", 0.3) : getColor("slate.300")
                },
                border: {
                  display: false,
                  dash: [2, 2]
                }
              }
            }
          }
        });
        helper.watchCssVariables("html", ["color-primary"], (newValues) => {
          reportLineChart1.data.datasets[0].borderColor = getColor(
            "primary",
            0.7
          );
          reportLineChart1.data.datasets[0].pointBorderColor = getColor(
            "primary",
            0.7
          );
          reportLineChart1.update();
        });
      });
    }
  })();
})();
