using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ClientTicket.Startup))]
namespace ClientTicket
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
