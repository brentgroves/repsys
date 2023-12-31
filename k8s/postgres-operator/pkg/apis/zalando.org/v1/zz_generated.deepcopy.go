// +build !ignore_autogenerated

/*
Copyright 2021 Compose, Zalando SE

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

// Code generated by deepcopy-gen. DO NOT EDIT.

package v1

import (
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Connection) DeepCopyInto(out *Connection) {
	*out = *in
	if in.PublicationName != nil {
		in, out := &in.PublicationName, &out.PublicationName
		*out = new(string)
		**out = **in
	}
	in.DBAuth.DeepCopyInto(&out.DBAuth)
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Connection) DeepCopy() *Connection {
	if in == nil {
		return nil
	}
	out := new(Connection)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DBAuth) DeepCopyInto(out *DBAuth) {
	*out = *in
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DBAuth) DeepCopy() *DBAuth {
	if in == nil {
		return nil
	}
	out := new(DBAuth)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStream) DeepCopyInto(out *EventStream) {
	*out = *in
	in.EventStreamFlow.DeepCopyInto(&out.EventStreamFlow)
	in.EventStreamRecovery.DeepCopyInto(&out.EventStreamRecovery)
	in.EventStreamSink.DeepCopyInto(&out.EventStreamSink)
	in.EventStreamSource.DeepCopyInto(&out.EventStreamSource)
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStream) DeepCopy() *EventStream {
	if in == nil {
		return nil
	}
	out := new(EventStream)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamFlow) DeepCopyInto(out *EventStreamFlow) {
	*out = *in
	if in.PayloadColumn != nil {
		in, out := &in.PayloadColumn, &out.PayloadColumn
		*out = new(string)
		**out = **in
	}
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamFlow) DeepCopy() *EventStreamFlow {
	if in == nil {
		return nil
	}
	out := new(EventStreamFlow)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamRecovery) DeepCopyInto(out *EventStreamRecovery) {
	*out = *in
	if in.Sink != nil {
		in, out := &in.Sink, &out.Sink
		*out = new(EventStreamSink)
		(*in).DeepCopyInto(*out)
	}
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamRecovery) DeepCopy() *EventStreamRecovery {
	if in == nil {
		return nil
	}
	out := new(EventStreamRecovery)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamSink) DeepCopyInto(out *EventStreamSink) {
	*out = *in
	if in.MaxBatchSize != nil {
		in, out := &in.MaxBatchSize, &out.MaxBatchSize
		*out = new(uint32)
		**out = **in
	}
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamSink) DeepCopy() *EventStreamSink {
	if in == nil {
		return nil
	}
	out := new(EventStreamSink)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamSource) DeepCopyInto(out *EventStreamSource) {
	*out = *in
	in.Connection.DeepCopyInto(&out.Connection)
	if in.Filter != nil {
		in, out := &in.Filter, &out.Filter
		*out = new(string)
		**out = **in
	}
	in.EventStreamTable.DeepCopyInto(&out.EventStreamTable)
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamSource) DeepCopy() *EventStreamSource {
	if in == nil {
		return nil
	}
	out := new(EventStreamSource)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamTable) DeepCopyInto(out *EventStreamTable) {
	*out = *in
	if in.IDColumn != nil {
		in, out := &in.IDColumn, &out.IDColumn
		*out = new(string)
		**out = **in
	}
	return
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EventStreamTable) DeepCopy() *EventStreamTable {
	if in == nil {
		return nil
	}
	out := new(EventStreamTable)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *FabricEventStreamSpec) DeepCopyInto(out *FabricEventStreamSpec) {
	*out = *in
	if in.EventStreams != nil {
		in, out := &in.EventStreams, &out.EventStreams
		*out = make([]EventStream, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}

	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new FabricEventStreamSpec.
func (in *FabricEventStreamSpec) DeepCopy() *FabricEventStreamSpec {
	if in == nil {
		return nil
	}
	out := new(FabricEventStreamSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *FabricEventStream) DeepCopyInto(out *FabricEventStream) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new FabricEventStream.
func (in *FabricEventStream) DeepCopy() *FabricEventStream {
	if in == nil {
		return nil
	}
	out := new(FabricEventStream)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *FabricEventStream) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *FabricEventStreamList) DeepCopyInto(out *FabricEventStreamList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]FabricEventStream, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new FabricEventStreamList.
func (in *FabricEventStreamList) DeepCopy() *FabricEventStreamList {
	if in == nil {
		return nil
	}
	out := new(FabricEventStreamList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *FabricEventStreamList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}
