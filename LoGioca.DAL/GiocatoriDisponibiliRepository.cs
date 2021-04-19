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
    public class GiocatoriDisponibiliRepository : Repository<GiocatoriDisponibiliVw>, IGiocatoriDisponibiliRepository<GiocatoriDisponibiliVw>
    {

        public GiocatoriDisponibiliRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<GiocatoriDisponibiliVw> Find(Expression<Func<GiocatoriDisponibiliVw, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<GiocatoriDisponibiliVw>> FindAsync(Expression<Func<GiocatoriDisponibiliVw, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
