package main

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/urfave/cli"
)

func main() {
	var target string

	app := cli.NewApp()
	app.Name = "killcess"
	app.Usage = "cess [-t, -target] [target process command]"
	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:        "target, t",
			Value:       "",
			Usage:       "target process command",
			Destination: &target,
		},
	}
	app.Action = func(c *cli.Context) error {
		if target != "" {
			fmt.Println("Start", "🍣")
			err := exec.Command("sh", "-c", "kill -9 $(ps aux | grep "+target+" | awk 'NR==1' | awk '{print $2}')").Run()
			if err != nil {
				fmt.Println("Err", err)
			} else {
				fmt.Println("Success")
			}
			fmt.Println("Finish", "🍣")
		} else {
			fmt.Println("Plz set", "target process command with -t or -target")
			fmt.Println("ex)", "killcess -t tmux")
		}
		return nil
	}
	app.Run(os.Args)
}
