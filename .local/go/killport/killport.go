package main

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/urfave/cli"
)

func main() {
	var port string

	app := cli.NewApp()
	app.Name = "killport"
	app.Usage = "killport [-p, -port] [port number]"
	app.Flags = []cli.Flag {
    cli.StringFlag{
      Name: "port, p",
      Value: "",
      Usage: "port number for kill process",
			Destination: &port,
    },
  }
	app.Action = func(c *cli.Context) error {
		if port != "" {
			fmt.Println("Start", "🍣")
			err := exec.Command("sh", "-c", "kill -9 $(lsof -i:" + port + " | grep java | awk 'NR==1' | awk '{print $2}')").Run()
			if err != nil {
				fmt.Println("Err", err)
			}
			fmt.Println("Finish", "🍣")
	  } else {
			fmt.Println("Plz set", "port number with -p or -port option")
		}
		return nil
	}
	app.Run(os.Args)
}
