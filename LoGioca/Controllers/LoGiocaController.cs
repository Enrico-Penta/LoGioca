using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using LoGioca.Models;
using Microsoft.Extensions.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using LoGioca.DAL.Models;
using LoGioca.BLL.Service;
using LoGioca.BLL.DTOs;
using Microsoft.AspNetCore.Http;

namespace LoGioca.Controllers
{
    public class LoGiocaController : BaseController
    {
        private readonly ILggiocatoreServiceRepository<LggiocatoreDTO> _LggiocatoreServiceRepository;
        private readonly ISportServiceRepository<SportDTO> _sportServiceRepository;
        private readonly IGiocatoriDisponibiliServiceRepository<GiocatoriDisponibiliDTO> _giocatoriDisponibiliServiceRepository;
        public LoGiocaController(IConfiguration configuration,
            IHttpContextAccessor httpContextAccessor,
            ILggiocatoreServiceRepository<LggiocatoreDTO> LggiocatoreServiceRepository,
            ISportServiceRepository<SportDTO> sportServiceRepository,
            IGiocatoriDisponibiliServiceRepository<GiocatoriDisponibiliDTO> giocatoriDisponibiliServiceRepository
            ) : base(configuration, httpContextAccessor)
        {

            IConfiguration _config = configuration;
            _LggiocatoreServiceRepository = LggiocatoreServiceRepository;
            _sportServiceRepository = sportServiceRepository;
            _giocatoriDisponibiliServiceRepository = giocatoriDisponibiliServiceRepository;
        }

        public async Task<IActionResult> Index()
        {
            var versioneAmbiente = await GetAmbienteVersione();
            return View();
        }

        public async Task<IActionResult> popupPartita(string date)
        {
            popupPartitaDTO data = new popupPartitaDTO();
            data.giocatori = await _giocatoriDisponibiliServiceRepository.GetAllGiocatoriDisponibili();
            data.sport = _sportServiceRepository.GetAll();
            data.dataPartita = date;
            return PartialView("_popupPartita", data);
        }
    }
}









