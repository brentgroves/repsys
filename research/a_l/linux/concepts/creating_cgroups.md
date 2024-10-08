# **[creating cgroups](https://github.com/containerd/cgroups)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Go package for creating, managing, inspecting, and destroying cgroups. The resources format for settings on the cgroup uses the OCI runtime-spec found here

Examples (v1)
Create a new cgroup
This creates a new cgroup using a static path for all subsystems under /test.

/sys/fs/cgroup/cpu/test
/sys/fs/cgroup/memory/test
etc....
It uses a single hierarchy and specifies cpu shares as a resource constraint and uses the v1 implementation of cgroups.

shares := uint64(100)
control, err := cgroup1.New(cgroup1.StaticPath("/test"), &specs.LinuxResources{
    CPU: &specs.LinuxCPU{
        Shares: &shares,
    },
})
defer control.Delete()
Create with systemd slice support
control, err := cgroup1.New(cgroup1.Systemd, cgroup1.Slice("system.slice", "runc-test"), &specs.LinuxResources{
    CPU: &specs.CPU{
        Shares: &shares,
    },
})
Load an existing cgroup
control, err = cgroup1.Load(cgroup1.Default, cgroups.StaticPath("/test"))
Add a process to the cgroup
if err := control.Add(cgroup1.Process{Pid:1234}); err != nil {
}
Update the cgroup
To update the resources applied in the cgroup

shares = uint64(200)
if err := control.Update(&specs.LinuxResources{
    CPU: &specs.LinuxCPU{
        Shares: &shares,
    },
}); err != nil {
}
Freeze and Thaw the cgroup
if err := control.Freeze(); err != nil {
}
if err := control.Thaw(); err != nil {
}
List all processes in the cgroup or recursively
processes, err := control.Processes(cgroup1.Devices, recursive)
Get Stats on the cgroup
stats, err := control.Stat()
By adding cgroups.IgnoreNotExist all non-existent files will be ignored, e.g. swap memory stats without swap enabled

stats, err := control.Stat(cgroup1.IgnoreNotExist)
Move process across cgroups
This allows you to take processes from one cgroup and move them to another.

err := control.MoveTo(destination)
Create subcgroup
subCgroup, err := control.New("child", resources)
Registering for memory events
This allows you to get notified by an eventfd for v1 memory cgroups events.

event := cgroup1.MemoryThresholdEvent(50 *1024* 1024, false)
efd, err := control.RegisterMemoryEvent(event)
event := cgroup1.MemoryPressureEvent(cgroup1.MediumPressure, cgroup1.DefaultMode)
efd, err := control.RegisterMemoryEvent(event)
efd, err := control.OOMEventFD()
// or by using RegisterMemoryEvent
event := cgroup1.OOMEvent()
efd, err := control.RegisterMemoryEvent(event)
Examples (v2/unified)
Check that the current system is running cgroups v2
var cgroupV2 bool
if cgroups.Mode() == cgroups.Unified {
 cgroupV2 = true
}
Create a new cgroup
This creates a new systemd v2 cgroup slice. Systemd slices consider "-" a special character, so the resulting slice would be located here on disk:

/sys/fs/cgroup/my.slice/my-cgroup.slice/my-cgroup-abc.slice
import (
    "github.com/containerd/cgroups/v3/cgroup2"
    specs "github.com/opencontainers/runtime-spec/specs-go"
)

res := cgroup2.Resources{}
// dummy PID of -1 is used for creating a "general slice" to be used as a parent cgroup.
// see <https://github.com/containerd/cgroups/blob/1df78138f1e1e6ee593db155c6b369466f577651/v2/manager.go#L732-L735>
m, err := cgroup2.NewSystemd("/", "my-cgroup-abc.slice", -1, &res)
if err != nil {
 return err
}
Load an existing cgroup
m, err := cgroup2.LoadSystemd("/", "my-cgroup-abc.slice")
if err != nil {
 return err
}
Delete a cgroup
m, err := cgroup2.LoadSystemd("/", "my-cgroup-abc.slice")
if err != nil {
 return err
}
err = m.DeleteSystemd()
if err != nil {
 return err
}
Kill all processes in a cgroup
m, err := cgroup2.LoadSystemd("/", "my-cgroup-abc.slice")
if err != nil {
 return err
}
err = m.Kill()
if err != nil {
 return err
}
Get and set cgroup type
m, err := cgroup2.LoadSystemd("/", "my-cgroup-abc.slice")
if err != nil {
    return err
}

// <https://www.kernel.org/doc/html/v5.0/admin-guide/cgroup-v2.html#threads>
cgType, err := m.GetType()
if err != nil {
    return err
}
fmt.Println(cgType)

err = m.SetType(cgroup2.Threaded)
if err != nil {
    return err
}
Attention
All static path should not include /sys/fs/cgroup/ prefix, it should start with your own cgroups name
