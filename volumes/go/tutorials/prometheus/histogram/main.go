// https://github.com/andykuszyk/prometheus-histogram-example
package main

import (
	"log"
	"math/rand"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
	histogram := promauto.NewHistogram(prometheus.HistogramOpts{
		Name:    "histogram_metric",
		Buckets: []float64{1.0, 2.0, 3.0, 4.0, 5.0},
	})
	go func() {
		for {
			histogram.Observe(rand.Float64() * 5.0)
			time.Sleep(1 * time.Second)
		}
	}()
	http.Handle("/metrics", promhttp.Handler())
	log.Fatal(http.ListenAndServe(":8080", nil))
}
