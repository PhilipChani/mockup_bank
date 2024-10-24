(() => {
  // src/js/components/report-donut-chart-1.js
  (function() {
    "use strict";
    const chartEl = $(".report-donut-chart-1");
    if (chartEl.length) {
      chartEl.each(function() {
        const ctx = $(this)[0].getContext("2d");
        const reportDonutChart1 = new Chart(ctx, {
          type: "doughnut",
          data: {
            labels: [
              "17 - 30 Years old",
              "31 - 50 Years old",
              ">= 50 Years old"
            ],
            datasets: [
              {
                data: [15, 10, 65],
                backgroundColor: [
                  getColor("pending", 0.5),
                  getColor("warning", 0.5),
                  getColor("primary", 0.5)
                ],
                hoverBackgroundColor: [
                  getColor("pending", 0.5),
                  getColor("warning", 0.5),
                  getColor("primary", 0.5)
                ],
                borderWidth: 1,
                borderColor: [
                  getColor("pending", 0.75),
                  getColor("warning", 0.9),
                  getColor("primary", 0.5)
                ]
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
            cutout: "90%"
          }
        });
        helper.watchCssVariables(
          "html",
          ["color-pending", "color-warning", "color-primary"],
          (newValues) => {
            reportDonutChart1.data.datasets[0].borderColor = [
              getColor("pending", 0.75),
              getColor("warning", 0.9),
              getColor("primary", 0.5)
            ];
            reportDonutChart1.data.datasets[0].hoverBackgroundColor = [
              getColor("pending", 0.5),
              getColor("warning", 0.5),
              getColor("primary", 0.5)
            ];
            reportDonutChart1.data.datasets[0].backgroundColor = [
              getColor("pending", 0.5),
              getColor("warning", 0.5),
              getColor("primary", 0.5)
            ];
            reportDonutChart1.update();
          }
        );
      });
    }
  })();
})();
