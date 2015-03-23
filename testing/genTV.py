alist = [5, 3, 2, 1, 5, 6, 7, 30]
clist = [3]

# Create testvector file
filename = 't1.v'
f = open(filename, 'w')

# Generate coefficient list
for coef in clist:

	# Shift each of the bits of c into the coef registers
	bC = bin(coef)[2:]
	bC = bC.zfill(8)

	print bC

	# Shift each bit
	for bit in bC:
		# Toggle shiftClk1 to shift in the bit
		f.write('1_' + bit + '_00000000\n')
		f.write('0_' + bit + '_00000000\n')

# Run through the data vectors
for a in alist:
	bA = bin(a)[2:]
	bA = bA.zfill(8)
	print bA

	for i in xrange(4):
		f.write('0_0_' + bA + '\n')

f.close()


