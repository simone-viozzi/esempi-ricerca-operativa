import glpk            # Import the GLPK module

lp = glpk.LPX()        # Create empty problem instance
lp.name = "mix produttivo per un'azienda alimentare"     # Assign symbolic name to problem

lp.obj.maximize = True # Set this as a maximization problem
lp.rows.add(3)         # Append three rows to this instance

lp.rows[0].name = 'cm'
lp.rows[1].name = 'cp'
lp.rows[2].name = 'cc'

lp.rows[0].bounds = (None, 40.0)
lp.rows[1].bounds = (None, 132.0)
lp.rows[2].bounds = (None, 140.0)

lp.cols.add(2)

lp.cols[0].name = 'F'
lp.cols[1].name = 'R'

lp.cols[0].bounds = (0.0, None)
lp.cols[1].bounds = (0.0, None)

lp.obj[:] = [ 24.0, 18.0 ]

lp.matrix = [ 1.0, 1.0,    
              4.5, 2.0,      
              2.0, 4.0, ]

lp.simplex()           # Solve this LP with the simplex method

print(lp.status)

lp.exact()
lp.interior()
lp.integer()
lp.intopt()

print(lp.status)

print(f'Z = {lp.obj.value}') # Retrieve and print obj func value
print('; '.join('%s = %g' % (c.name, c.primal) for c in lp.cols))
                       # Print struct variable names and primal values