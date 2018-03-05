package ld_gauche_links

import (
	"github.com/launchdarkly/gauche-links/server"
)

func init() {
	err := server.Start()
	if err != nil {
		panic(err)
	}
}
