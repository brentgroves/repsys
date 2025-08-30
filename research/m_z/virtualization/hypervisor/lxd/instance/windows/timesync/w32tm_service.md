# w32tm the service has not been started

To resolve the "w32tm service has not been started" error, use the Services console ( services.msc ) to set the Windows Time service (w32time) to start automatically and then manually start it. If this doesn't work, run an elevated Command Prompt and execute net stop w32time, w32tm /unregister, w32tm /register, and net start w32time to re-register the service.
Using the Services Console
Open Services: Press the Windows key + R, type services.msc, and press Enter.
Locate Windows Time: In the Services window, scroll down and find the Windows Time service.
Set Startup Type: Double-click on the service and change the "Startup type" to Automatic.
Start the Service: If the "Service status" is not "Running," click the Start button.
Apply and Close: Click Apply and then OK.
