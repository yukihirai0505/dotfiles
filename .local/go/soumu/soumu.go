package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/mitchellh/go-homedir"
	"github.com/urfave/cli"
)

/***
if runtime.GOOS == "windows" {
fmt.Println(runtime.GOOS)
} else {
fmt.Println(runtime.GOOS)
}***/

var (
	h, _         = homedir.Dir()
	downloadsDir = h + "/Downloads/"
	desktopDir   = h + "/Desktop/"
	trashDir     = h + "/.Trash/"
	directories  = [3]string{downloadsDir, desktopDir, trashDir}
)

func main() {
	app := cli.NewApp()
	app.Name = "soumu"
	app.Usage = "hey! fxxx soumu!"
	app.Action = func(c *cli.Context) error {

		for i := 0; i < len(directories); i++ {
			if err := RemoveContents(directories[i]); err != nil {
				fmt.Println(err)
			}
		}
		return nil
	}
	app.Run(os.Args)
}

func RemoveContents(dir string) error {
	d, err := os.Open(dir)
	if err != nil {
		return err
	}
	defer d.Close()
	names, err := d.Readdirnames(-1)
	if err != nil {
		return err
	}
	for _, name := range names {
		err = os.RemoveAll(filepath.Join(dir, name))
		if err != nil {
			return err
		}
	}
	return nil
}
