using LogiBox.BLL.DTOs;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;

namespace LoGioca.Utility
{
    public class SessionManager
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public SessionManager(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }
        public UserDTO _user
        {
            get
            {
                var prova = _httpContextAccessor.HttpContext.Session.Get<UserDTO>("user");
                return prova;
            }
            set
            {
                _httpContextAccessor.HttpContext.Session.Set("user", value);
            }
        }
    }
    public static class SessionExtensions
    {
        public static void Set<T>(this ISession session, string key, T value)
        {
            session.Set(key, JsonSerializer.SerializeToUtf8Bytes(value));
        }



        public static T Get<T>(this ISession session, string key)
        {
            var value = session.Get(key);



            return value == null ? default :
                JsonSerializer.Deserialize<T>(value);
        }
    }
}
