﻿using LoGioca.DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoGioca.DAL
{
    public interface ILgpartitaRepository<T> : IRepository<T> where T : class
    {
    }
}
