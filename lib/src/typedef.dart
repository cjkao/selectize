
typedef Func1<T,R> = R Function<T,R>( T t);
typedef StrFunc1 = String Function( String t);
typedef Func2<T,T2,R> = R Function<T,T2,R>(T a, T2 b);
typedef VoidFunc0 = void Function();
typedef VoidFunc1<A> = void Function<A>(A a);
typedef VoidFunc2<A,B> = void Function<A,B>(A a,B b);