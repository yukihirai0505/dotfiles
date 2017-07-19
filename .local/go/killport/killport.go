package main

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/urfave/cli"
)

func main() {
	var port string
	var target string

	app := cli.NewApp()
	app.Name = "killport"
	app.Usage = "killport [-p, -port] [port number] [-t, -target] [target process command]"
	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:        "port, p",
			Value:       "",
			Usage:       "port number for kill process",
			Destination: &port,
		},
		cli.StringFlag{
			Name:        "target, t",
			Value:       "",
			Usage:       "target process command",
			Destination: &target,
		},
	}
	app.Action = func(c *cli.Context) error {
		if port != "" && target != "" {
			fmt.Println("Start", "🍣")
			err := exec.Command("sh", "-c", "kill -9 $(lsof -i:"+port+" | grep "+target+" | awk 'NR==1' | awk '{print $2}')").Run()
			if err != nil {
				fmt.Println("Err", err)
			}
			fmt.Println("Finish", "🍣")
		} else {
			fmt.Println("Plz set", "port number with -p or -port option and target process command with -t or -target")
			fmt.Println("ex)", "killport -p 9010 -t java")
		}
		return nil
	}
	app.Run(os.Args)
}
