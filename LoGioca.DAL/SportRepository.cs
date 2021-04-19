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
    public class SportRepository : Repository<Sport>, ISportRepository<Sport>
    {

        public SportRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<Sport> Find(Expression<Func<Sport, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<Sport>> FindAsync(Expression<Func<Sport, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
