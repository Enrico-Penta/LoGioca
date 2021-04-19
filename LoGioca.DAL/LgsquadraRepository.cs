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
    public class LgsquadraRepository : Repository<Lgsquadra>, ILgsquadraRepository<Lgsquadra>
    {

        public LgsquadraRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<Lgsquadra> Find(Expression<Func<Lgsquadra, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<Lgsquadra>> FindAsync(Expression<Func<Lgsquadra, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
