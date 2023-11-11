
===== CRASH =====
si_signo=Segmentation fault(11), si_code=1, si_addr=0x4d5003d0131
version=2.18.7 (stable) (Unknown timestamp) on "linux_x64"
pid=12327, thread=12349, isolate_group=main(0x558f0943f800), isolate=Runner.isolateMain(0x558f0a156800)
isolate_instructions=558f06e79680, vm_instructions=558f06e79680
  pc 0x0000558f06f9e108 fp 0x00007ff8e637c900 dart+0x2028108
  pc 0x0000558f0706cb4c fp 0x00007ff8e637c9a0 dart::Class::GetInvocationDispatcher(dart::String const&, dart::Array const&, dart::UntaggedFunction::Kind, bool) const+0xfc
  pc 0x0000558f0712f377 fp 0x00007ff8e637ca00 dart::InlineCacheMissHelper(dart::Class const&, dart::Array const&, dart::String const&)+0x107
  pc 0x0000558f0713060b fp 0x00007ff8e637ca60 dart::PatchableCallHandler::ResolveTargetFunction(dart::Object const&)+0x24b
  pc 0x0000558f07130640 fp 0x00007ff8e637cad0 dart::PatchableCallHandler::ResolveSwitchAndReturn(dart::Object const&)+0x20
  pc 0x0000558f071312de fp 0x00007ff8e637d1b0 dart::DRT_SwitchableCallMiss(dart::NativeArguments)+0x38e
  pc 0x00007ff8fe7025c3 fp 0x00007ff8e637d1f0 Unknown symbol
  pc 0x00007ff8fe702ace fp 0x00007ff8e637d230 Unknown symbol
  pc 0x00007ff8e931aa0c fp 0x00007ff8e637d280 Unknown symbol
  pc 0x00007ff8f894fe1d fp 0x00007ff8e637d308 Unknown symbol
  pc 0x00007ff8ecbb6abb fp 0x00007ff8e637d358 Unknown symbol
  pc 0x00007ff8eeffde69 fp 0x00007ff8e637d3e0 Unknown symbol
  pc 0x00007ff8e9304675 fp 0x00007ff8e637d420 Unknown symbol
  pc 0x00007ff8f8949efb fp 0x00007ff8e637d460 Unknown symbol
  pc 0x00007ff8e9327663 fp 0x00007ff8e637d488 Unknown symbol
  pc 0x00007ff8e9327430 fp 0x00007ff8e637d4c8 Unknown symbol
  pc 0x00007ff8fe702a0c fp 0x00007ff8e637d540 Unknown symbol
  pc 0x0000558f06ff183d fp 0x00007ff8e637d5e0 dart::DartEntry::InvokeCode(dart::Code const&, unsigned long, dart::Array const&, dart::Array const&, dart::Thread*)+0x14d
  pc 0x0000558f06ff167c fp 0x00007ff8e637d640 dart::DartEntry::InvokeFunction(dart::Function const&, dart::Array const&, dart::Array const&, unsigned long)+0x14c
  pc 0x0000558f06ff3aac fp 0x00007ff8e637d690 dart::DartLibraryCalls::HandleMessage(long, dart::Instance const&)+0x14c
  pc 0x0000558f0701b170 fp 0x00007ff8e637dc20 dart::IsolateMessageHandler::HandleMessage(std::__2::unique_ptr<dart::Message, std::__2::default_delete<dart::Message> >)+0x350
  pc 0x0000558f0704469d fp 0x00007ff8e637dc90 dart::MessageHandler::HandleMessages(dart::MonitorLocker*, bool, bool)+0x14d
  pc 0x0000558f07044d7f fp 0x00007ff8e637dce0 dart::MessageHandler::TaskCallback()+0x1df
  pc 0x0000558f071677b8 fp 0x00007ff8e637dd60 dart::ThreadPool::WorkerLoop(dart::ThreadPool::Worker*)+0x148
  pc 0x0000558f07167c0d fp 0x00007ff8e637dd90 dart::ThreadPool::Worker::Main(unsigned long)+0x6d
  pc 0x0000558f070da858 fp 0x00007ff8e637de50 dart+0x2164858
-- End of DumpStackTrace
  pc 0x0000000000000000 fp 0x00007ff8e637d1f0 sp 0x0000000000000000 [Stub] CallToRuntime
  pc 0x00007ff8fe702ace fp 0x00007ff8e637d230 sp 0x00007ff8e637d200 [Stub] SwitchableCallMiss
  pc 0x00007ff8e931aa0c fp 0x00007ff8e637d280 sp 0x00007ff8e637d240 [Unoptimized] _NativeSocket@14069316.write.<anonymous closure>
  pc 0x00007ff8f894fe1d fp 0x00007ff8e637d308 sp 0x00007ff8e637d290 [Optimized] _rootRun@4048458
  pc 0x00007ff8ecbb6abb fp 0x00007ff8e637d358 sp 0x00007ff8e637d318 [Optimized] _rootRun@4048458
  pc 0x00007ff8eeffde69 fp 0x00007ff8e637d3e0 sp 0x00007ff8e637d368 [Optimized] _CustomZone@4048458.bindCallback.<anonymous closure>
  pc 0x00007ff8e9304675 fp 0x00007ff8e637d420 sp 0x00007ff8e637d3f0 [Optimized] _microtaskLoop@4048458
  pc 0x00007ff8f8949efb fp 0x00007ff8e637d460 sp 0x00007ff8e637d430 [Unoptimized] _startMicrotaskLoop@4048458
  pc 0x00007ff8e9327663 fp 0x00007ff8e637d488 sp 0x00007ff8e637d470 [Optimized] _startMicrotaskLoop@4048458
  pc 0x00007ff8e9327430 fp 0x00007ff8e637d4c8 sp 0x00007ff8e637d498 [Optimized] _RawReceivePortImpl@1026248._handleMessage@1026248
  pc 0x00007ff8fe702a0c fp 0x00007ff8e637d540 sp 0x00007ff8e637d4d8 [Stub] InvokeDartCode
Aborted (core dumped)


https://drive.google.com/file/d/1EGt-Yvs4OjWlPekJtHkehEZqTEDHYBOt/view?usp=sharing