using Microsoft.EntityFrameworkCore;
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
    public class LgpartitaRepository : Repository<Lgpartita>, ILgpartitaRepository<Lgpartita>
    {

        public LgpartitaRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<Lgpartita> Find(Expression<Func<Lgpartita, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<Lgpartita>> FindAsync(Expression<Func<Lgpartita, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
