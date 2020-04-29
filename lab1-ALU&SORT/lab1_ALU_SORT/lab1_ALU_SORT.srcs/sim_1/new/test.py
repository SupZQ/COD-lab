def print_rhombus(n):
    x=n//2;
    print(' '*(x)+'*')
    for i in range(1,x):
        print(' '*abs(i-x)+'*'+' '*(2*abs(x-i)-1)+'*');
    print(' '*x+'*')
n=eval(input("Please enter an odd integer："))
print_rhombus(n)
