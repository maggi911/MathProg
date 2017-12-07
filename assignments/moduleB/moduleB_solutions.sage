'''
Group Members
=============
'''

userids = ['andreas17', 'karin17'] # fill in this array with strings of usernames


class Catalan(SageObject):
    """
    The base class for all Catalan structures
    """
    def __init__(self, obj=None):
        self.obj = self.neutral_element if obj is None else obj

    def _repr_(self):
        return "%s(%s)" % (self.__class__.__name__, repr(self.obj))

    def __eq__(self, other):
        return self.obj == other.obj

    def cons(self, other=None):
        raise NotImplementedError

    def decons(self):
        raise NotImplementedError

    def is_neutral(self):
        return self.obj == self.neutral_element

    def map_to(self, cls):
        """
        The image of self under the canonical bijection
        induced by the class of self and cls
        """
        pass

    @classmethod
    def structures(cls, n):
        """
        Generates all structures of size n
        """
        pass


class Av132(Catalan):
    """
    The class of 132-avoiding permutations
    """
    neutral_element = []

    def cons(self, other=None):
        """
        Constructs a 132-avoiding permutation from
        the 132-avoiding permutations self and other
        """
        pass

    def decons(self):
        """
        Deconstructs the 132-avoiding permutation self
        into two 132-avoiding permutations:
        ’decons’ is the inverse of ’cons’
        """
        pass


class Dyck(Catalan):
    """
    The class of Dyck paths
    """
    neutral_element = []
    def cons(self, other=None):
        """
        Constructs a Dyck path from
        the Dyck paths self and other
        """
        pass
    def decons(self):
        """
        Deconstructs the Dyck path self
        into two Dyck paths:
        ’decons’ is the inverse of ’cons’
        """
        pass


def to_standard(p):
    '''Return the standardization of p
    '''
    n = len(p)
    l = [0] * n

    for i, (index, _) in enumerate(sorted(enumerate(p), key=lambda x:x[1]), start=1):
        l[index] = i
    return l

def get_subsequences(p, cl):
    '''Outputs a set of sets of indices of subsequences of p that have a pattern cl
    '''
    if len(cl) > len(p):
        return []

    def check_pattern(a, b):
        return to_standard(a) == b

    cl_std = to_standard(cl)
    n, q = len(p), len(cl)

    L = set()

    for i in Subsets(xrange(n), q):
        if check_pattern([p[x] for x in i], cl_std):
            L.add(i)

    return L

def mBp1(perm, mp):
    '''Return True if the permutation perm contains the
    mesh pattern mp
    '''

    def get_coordinate((x, y), L):
        i = 0
        for (k, _) in L:
            if x < k:
                break
            else:
                i += 1
        j = 0
        for (_, k) in L:
            if y < k:
                break
            else:
                j += 1
        return (i, j)

    def is_valid(perm, subseq, tiles):
        for i in set(xrange(len(perm))) - set(subseq):
            if get_coordinate((i, perm[i]), [(j, perm[j]) for j in subseq]) in tiles:
                return False
        return True

    possible_subseq = get_subsequences(perm, mp[0])
    if len(possible_subseq) == 0:
        return False

    n, k = len(perm), len(mp[0]) # length of permutation, length of classical pattern

    for subseq in possible_subseq:
        if is_valid(perm, subseq, mp[1]):
            return True
    return False


def mBp2():
    '''Output a list of patterns [p,q] such that Av(p,q) = permutations perm such that S(S(perm)) is fully sorted
    '''
    return []

def mBp3(perm):
    '''Return the pair of Young tableaux that correspond to perm
    '''
    return [[]]

def mBp4():
    '''Output a pattern p such that Av(p) = permutations whose Young tableaux have at most three cells in the first row
    '''
    return []

def mBp5():
    '''Output a pattern p such that Av(p) = permutations whose Young tableaux have at most three cells in the first column
    '''
    return []

def mBp6():
    '''Output a pattern p such that Av(p) = permutations whose Young tableaux is hook-shaped
    '''
    return []

def mBp7(avperm):
    '''Return the decomposition of avperm
    '''
    return (Av132([]), Av132([]))

def mBp8(avperm1, avperm2):
    '''Return the gluing of avperm1 and avperm2
    '''
    return Av132([])

def mBp9(dyck1, dyck2):
    '''Return the gluing of dyck1 and dyck2
    '''
    return Dyck([])

def mBp10(dyck):
    '''Return the decomposition of dyck
    '''
    return (Dyck([]), Dyck([]))

def mBp11(n):
    '''Return the 132-avoiding permutations of length n
    '''
    return []

def mBp12(avperm):
    '''Return the Dyck-path that corresponds to avperm
    '''
    return Dyck([])

