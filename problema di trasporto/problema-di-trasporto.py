import glpk            

lp = glpk.LPX()       
lp.name = 'problema di trasporto'    

nomi_magazzini = [ 'La Spezia', 'Trieste', 'Ancona', 'Napoli', 'Bari' ]
disp_magazzini = [ 20, 15, 25, 33, 21 ]
assert len(nomi_magazzini) == len(disp_magazzini)

nomi_porti = [ 'Padova', 'Arezzo', 'Roma', 'Teramo', 'Lecce', 'Catanzaro' ]
rich_porti = [ 10, 12, 20, 24, 18, 40 ]
assert len(nomi_porti) == len(rich_porti)

lp.obj.maximize = False

lp.rows.add(len(nomi_magazzini))

for i in range(len(nomi_magazzini)):
    lp.rows[i].name = nomi_magazzini[i]
    lp.rows[i].bounds = (None, disp_magazzini[i])

lp.cols.add(len(nomi_porti))

for i in range(len(nomi_porti)):
    lp.cols[i].name = nomi_porti[i]
    lp.cols[i].bounds = (rich_porti[i], None)
    lp.cols[i].kind = int

help(lp)

lp.write(cpxlp='problema-di-trasporto')

lp.obj[:] = [ 60, 65, 45, 55 ]

lp.matrix = [ 3, 5, 1, 2 ]

lp.simplex()
lp.integer() # -> per ottenere soluzioni intere

print(f'profitto = {lp.obj.value}') # Retrieve and print obj func value
print('; '.join('%s = %g' % (c.name, c.primal) for c in lp.cols))