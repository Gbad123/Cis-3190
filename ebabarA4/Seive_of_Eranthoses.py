import time

print("Enter the range or 0 to end")
#getting user input
n = input()
#print n,

start_time = time.time()
if(n != 0):
    #creating a boolean array
    prime = [True for i in range(n+1)]
    j = 2
    while(j*j <= n):
        #if not changed it's prime
        if(prime[j] == True):
            #setting multiples of a nuber to false
            for i in range(j*2,n+1,j):
                prime[i]=False
        j+=1
        #printing the answer

    output = open("output.txt", "a")
    output.write("in python\n")
    for i in range(2,n):
        if prime[i]:
            output.write(str(i) + ', ')
    #printing the run time
    output.write("\nend python\n")
    output.close()
    print("\n%s second" % (time.time()-start_time))
