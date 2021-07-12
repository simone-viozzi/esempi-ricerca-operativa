from pyomo.environ import *
model = ConcreteModel('problema di trasporto')

utensili = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
job = { 'job1': [  800, ('A', 'C', 'D', 'E')], 
        'job2': [ 1200, ('A', 'B', 'C', 'E')],
        'job3': [  950, ('B', 'D', 'E', 'G')],
        'job4': [  860, ('E', 'F', 'G')], 
        'job5': [  750, ('A', 'D', 'G')] }

model.utensili = Set(initialize=utensili)
model.jobs = Set(initialize=job.keys())
0

def ut_jobs_init(model):
    ret = []
    for key, value in job.items():

        ret.append(list(value[1]))
    return ret

model.ut_jobs = Set(model.jobs, initialize=ut_jobs_init)

model.prof = Param(model.jobs, initialize={key: value[0] for key, value in job.items()})


model.select_utens = Var(model.utensili, domain=Boolean)
model.select_job = Var(model.jobs, domain=Boolean)

def job_possib(model, j):
    utens = set(model.select_utens)
    if utens.issubset(model.ut_job[j][1]):
        return model.select_job[j] == 1
    else:
        return model.select_job[j] == 0

model.sel_job = Constraint(model.jobs, rule = job_possib)

model.max_utens = Constraint(expr = sum(model.select_utens[u] for u in model.utensili) <= 5)

obj_expr = sum(model.select_job[j]*model.prof[j] for j in model.jobs)
model.cost = Objective(expr = obj_expr, sense=maximize)

SolverFactory('glpk').solve(model)

model.pprint()