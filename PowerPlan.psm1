# Copyright 2015 Jeremiah Peschka
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function Set-PowerPlan ($powerPlan = "balanced") {
    try {
        $powerPlan = $powerPlan.toLower()
        $perf = powercfg -l | %{if($_.toLower().contains($powerPlan)) {$_.split()[3]}}
        $currentPlan = $(powercfg -getactivescheme).split()[3]

        if ($currentPlan -ne $perf) {
            powercfg -setactive $perf
        }
    } catch {
        Write-Warning -Message "Unabled to set power plan to $powerPlan"
    }
}

function Set-PowerSaver {
    Set-PowerPlan("power saver")
}

function Set-PowerHighPerformance {
    Set-PowerPlan("high performance")
}

function Set-PowerBalanced {
    Set-PowerPlan("balanced")
}

function Set-ScreenSaverTimeout([Int32]$value)
{
    $seconds = $value * 60
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name ScreenSaveTimeOut -Value $seconds

    if ($value -eq 0) {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name ScreenSaveActive -Value 0
    }
    else {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name ScreenSaveActive -Value 1
    }
}

function Set-DisplaySleep([int]$monitor = 15, [int]$sleep = 30, [int]$screenSaver = 10) {
    POWERCFG -change -standby-timeout-ac $sleep;
    POWERCFG -change -monitor-timeout-ac $monitor;
    Set-ScreenSaverTimeout $screenSaver;
}

function Set-PresentationModeOff() {
    # use the defaults we set up earlier
    Set-DisplaySleep;
    Set-PowerBalanced;
}

function Set-PresentationModeOn() {
    Set-DisplaySleep -monitor 0 -sleep 0 -screenSaver 0;
    Set-PowerHighPerformance;
}