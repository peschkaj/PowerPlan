# PowerPlan
Windows power management using PowerShell - this provides a set of commands for controlling the power plan on a Windows computer.

## Available Commands

* `Set-PowerPlan` - Will set the current power plan. This has to match an existing power plan. Get current power plans using `powercfg -l`.
* `Set-PowerSaver` - Sets the current plan to "Power saver".
* `Set-PowerHighPerformance` - Sets to the "High Performance" power plan.
* `Set-PowerBalanced` - Sets a balanced power plan.
* `Set-ScreenSaverTimeout` - Set the screen saver time out in minutes.
* `Set-DisplaySleep` - Sets the display sleep settings. Parameters are `$monitor` (monitor off), `$sleep` (sleep time), `$screenSaver` (calls `Set-ScreenSaverTimeout`)
* `Set-PresentationModeOff` - Uses my default settings to turn off presentation mode.
* `Set-PresentationModeOn` - Totally disables the screen saver and sets the power to high performance.
