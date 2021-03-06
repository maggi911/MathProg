'''
Group Members
=============
'''

userids = ['karin17'] # fill in this array with strings of usernames
def m2p1(n):
    '''Given a non-negative integer n calculate n-th Tribonacci number, using recursion.
    '''
    if n <= 1:
        return 0
    if n == 2:
        return 1
    return m2p1(n - 1) + m2p1(n - 2) + m2p1(n - 3)

memo_m2p2 = {0:0, 1:0, 2:1}
def m2p2(n):
    '''Given a non-negative integer n calculate n-th Tribonacci number, using recursion and memoization.
    '''
    if n in memo_m2p2:
        return memo_m2p2[n]
    else:
        memo_m2p2[n] = m2p2(n - 1) + m2p2(n - 2) + m2p2(n - 3)
        return memo_m2p2[n]

def m2p3(n):
    '''Given a non-negative integer n calculate n-th Tribonacci number using memoization with a list, and without using recursion
    '''
    # Initializing a list to contain the values
    T = [0, 0, 1] + [0] * (n - 2)

    for i in xrange(3, n + 1):
        T[i] = T[i - 1] + T[i - 2] + T[i - 3]
    return T[n]

def m2p4(n):
    '''Given a non-negative integer n calculate n-th Tribonacci number, without using recursion and only storing three values.
    '''
    if n <= 1:
        return 0

    t3, t2, t1 = 1, 0, 0

    for i in xrange(3, n + 1):
        t3, t2, t1 = t3 + t2 + t1, t3, t2
    return t3

def m2p5(n,L):
    '''Project Euler Problem 31.
The input n is a positive integer and the input L is a list of coin values.
The returned value is the number of ways n can be split using the coin values in the list L.
    '''
    L = sorted(L, reverse = True)

    def helper(amount, lst):
        if amount == 0:
            return 1
        elif len(lst) == 0:
            return 0
        c = 0
        for i in xrange(0, amount // lst[0] + 1):
            c += helper(amount - i * lst[0], lst[1:] if len(lst) > 1 else [])
        return c

    return helper(n, L)

def m2p6(k):
    '''Project Euler Problem 76.
The input k should be a positive integer. The returned value is the number of
different ways k can be written as a sum of at least two positive integers.
    '''
    memo = {}

    def helper(left, max_number):
        if left == 0:
            return 1
        elif max_number <= 0:
            return 0
        if left in memo:
            if max_number in memo[left]:
                return memo[left][max_number]

        c = 0
        for i in xrange(0, left // max_number + 1):
            c += helper(left - i * max_number, max_number - 1)
        if left not in memo:
            memo[left] = {}
        memo[left][max_number] = c
        return c

    return helper(k, k - 1)

def m2p7(k):
    '''Project Euler Problem 77.
The input k should be a positive integer. The returned value is the smallest positive
integer n such that the number of ways to write n as a sum of primes exceeds k
    '''
    memo = {}

    def helper(left, max_number):
        if left == 0:
            return 1
        elif max_number <= 1:
            return 0
        if left in memo and max_number in memo[left]:
            return memo[left][max_number]

        c = 0
        for i in xrange(0, left // max_number + 1):
            c += helper(left - i * max_number, previous_prime(max_number) if max_number > 2 else 0)
        if left not in memo:
            memo[left] = {}
        memo[left][max_number] = c
        return c

    n = 0
    i = 0
    while n <= k:
        i += 1
        n = helper(i, previous_prime(i) if i > 2 else 0)
    return i

memo_m2p8 = {} # Cheating. I stores values from previous function runs.

def m2p8(k):
    '''Project Euler Problem 78.
The input k should be a positive integer. The returned value is the smallest positive
integer n such that number of ways n coins can be separated into piles is divisible by k.
    '''

    def helper(left, max_number):
        if left == 0:
            return 1
        elif max_number <= 0:
            return 0
        if left in memo_m2p8:
            if max_number in memo_m2p8[left]:
                return memo_m2p8[left][max_number]

        c = 0
        for i in xrange(0, left // max_number + 1):
            c += helper(left - i * max_number, max_number - 1)
        if left not in memo_m2p8:
            memo_m2p8[left] = {}
        memo_m2p8[left][max_number] = c
        return c

    n = -1
    i = 0
    while n < 0 or n % k != 0:
        i += 1
        n = helper(i, i - 1) + 1 # add one for one pile of all coins
    return i

def m2p9(M):
    '''Project Euler Problem 81.
The input M should be an n x n matrix containing integers, given as a list of lists.
The output is the minimal path sum, as defined on Project Euler.
    '''
    num_rows = len(M)
    num_columns = len(M[0])

    for y in xrange(num_rows):
        for x in xrange(num_columns):
            if y == 0 and x == 0:
                continue
            if y == 0:
                M[y][x] += M[y][x - 1]
            elif x == 0:
                M[y][x] += M[y - 1][x]
            else:
                M[y][x] += min(M[y - 1][x], M[y][x - 1])

    return M[num_rows - 1][num_columns - 1]
