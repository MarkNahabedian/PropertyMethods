
struct MyWrapper
    target
end

@delegate MyWrapper target a

@property_trampolines MyWrapper

@testset "test @delegate" begin
    ms = MyStruct(3)
    mw = MyWrapper(ms)
    @test mw.a == 3
end

