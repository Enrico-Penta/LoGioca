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
    public class ClassificaRelUtenteRepository : Repository<ClassificaRelUtente>, IClassificaRelUtente<ClassificaRelUtente>
    {

        public ClassificaRelUtenteRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<ClassificaRelUtente> Find(Expression<Func<ClassificaRelUtente, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<ClassificaRelUtente>> FindAsync(Expression<Func<ClassificaRelUtente, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
