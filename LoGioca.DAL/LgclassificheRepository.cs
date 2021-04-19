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
    public class LgclassificheRepository : Repository<Lgclassifiche>, ILgclassificheRepository<Lgclassifiche>
    {

        public LgclassificheRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<Lgclassifiche> Find(Expression<Func<Lgclassifiche, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<Lgclassifiche>> FindAsync(Expression<Func<Lgclassifiche, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
