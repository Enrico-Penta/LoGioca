﻿using Microsoft.EntityFrameworkCore;
using LoGioca.DAL.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using LoGioca.DAL;
using System.Transactions;
using System.Linq.Expressions;

namespace LoGioca.DAL
{
    public class LggiocatoreRepository : Repository<Lggiocatore>, ILggiocatoreRepository<Lggiocatore>
    {

        public LggiocatoreRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<Lggiocatore> Find(Expression<Func<Lggiocatore, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<Lggiocatore>> FindAsync(Expression<Func<Lggiocatore, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
