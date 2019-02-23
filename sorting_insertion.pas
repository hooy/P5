
Program sorting_insertions;

Uses CRT;

Const INF = 1000;

Type PItem = ^TItem;
  TItem = Record
    next: PItem;
    data: Integer;
  End;

Procedure Push(Var top: PItem; x: Integer);

Var p: PItem;
Begin
  New(p);
  p^.data := x;
  p^.next := top;
  top := p;
End;

Procedure LinkSwap(Var p1, p2, p3, p4: PItem);
// this procedure swaps 2 middle elements from 4 in linked list
Begin
  p2^.next := p4;
  p1^.next := p3;
  p3^.next := p2;
End;

Procedure Sort(Var top:PItem);

Var swapped: Boolean;
  // we need 3 runners
  // to swap r2 and r3, we also need to change r1 pointer to r3
  // and also r2 next shoul point to r4
  // r1 -> r2 -> r3 -> r4
  r1, r2, r3, r4: PItem;
  i: integer;
Begin
  Repeat
    swapped := false;
    r1 := top;
    r2 := r1^.next;
    r3 := r2^.next;
    r4 := r3^.next;
    i := 0;
    While (r3^.data <> INF)  Do
      Begin
        If (r2^.data > r3^.data) Then
          Begin
            LinkSwap(r1, r2, r3, r4);
            swapped := true;
          End;
        r1 := r1^.next;
        r2 := r2^.next;
        r3 := r3^.next;
        If (r3^.data <> INF) Then // if r3 points to INF then r4 nowhere to look
          r4 := r4^.next;
        i := i + 1;
      End;
    Inc(i);
  Until (Not swapped);
End;

Procedure Insert(Var top: PItem; x: Integer);

Var p, r: PItem;
Begin
  New(p);
  p^.data := x;
  r := top;
  While (x > r^.next^.data) Do
    Begin
      r := r^.next;
    End;
  p^.next := r^.next;
  r^.next := p;
End;

Procedure Pop(Var top: PItem);

Var p: PItem;
Begin
  If top^.data <> -INF Then
    Begin
      p := top;
      top := top^.next;
      Dispose(p);
    End;
End;

Procedure Print(top: PItem);
// Print list without -INF and +INF

Var r: PItem;
Begin
  r := top^.next;
  // skip first element as it always will be -INF
  While (r^.data <> INF) Do
    Begin
      write(r^.data:3);
      r := r^.next;
    End;
  writeln;
End;

Procedure TestInsertionSort;

Var s: PItem;
  i: Integer;
Begin
  // init first two elements, to avoid heomoroids later
  Push(s, INF);
  Push(s, -INF);

  // inserting random test data
  For i := 0 To 20 Do
    Begin
      Insert(s, Random(100));
    End;

  // numbers should be printed in ascending order
  writeln('=== Insertion sort: ');
  Print(s);

  writeln;
End;

Procedure TestSwapSort;

Var s: PItem;
  i: Integer;
Begin
  // put only +INF
  // remember that in "stack" we are pushing numbers from "end"
  Push(s, INF);

  // inserting random test data between -INF and INF
  For i := 0 To 10 Do
    Begin
      Push(s, Random(100));
    End;

  // should be PUT AFTER our numbers, so it is last element
  Push(s, -INF);

  // numbers should be printed in ascending order
  writeln('=== Swap sort: ');
  writeln('    list before sorting: ');
  write('   ');
  Print(s);
  Sort(s);
  writeln('    list after sorting: ');
  write('   ');
  Print(s);
  writeln;
End;


Begin
  Randomize;
  // ClrScr;
  TestInsertionSort;
  TestSwapSort
End.
