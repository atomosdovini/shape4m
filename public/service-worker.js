const CACHE_VERSION = 'shape4m-v1';
const CACHE_ASSETS = [
  '/',
  '/plan',
  '/profile',
  '/manifest.json'
];

// Instalar o service worker e fazer cache dos assets
self.addEventListener('install', (event) => {
  console.log('[Service Worker] Instalando...');
  event.waitUntil(
    caches.open(CACHE_VERSION).then((cache) => {
      console.log('[Service Worker] Cache aberto');
      return cache.addAll(CACHE_ASSETS);
    })
  );
  self.skipWaiting();
});

// Ativar o service worker e limpar caches antigos
self.addEventListener('activate', (event) => {
  console.log('[Service Worker] Ativando...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_VERSION) {
            console.log('[Service Worker] Removendo cache antigo:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  return self.clients.claim();
});

// Interceptar requisições e servir do cache quando possível
self.addEventListener('fetch', (event) => {
  // Ignora requisições não-GET
  if (event.request.method !== 'GET') {
    return;
  }

  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      // Retorna do cache se existir, senão busca da rede
      if (cachedResponse) {
        // Atualiza o cache em background
        fetch(event.request).then((response) => {
          if (response && response.status === 200) {
            caches.open(CACHE_VERSION).then((cache) => {
              cache.put(event.request, response.clone());
            });
          }
        }).catch(() => {
          // Falha silenciosa se offline
        });
        return cachedResponse;
      }

      // Se não está no cache, busca da rede
      return fetch(event.request).then((response) => {
        // Não cacheia se não for uma resposta válida
        if (!response || response.status !== 200 || response.type !== 'basic') {
          return response;
        }

        // Clona a resposta para cachear
        const responseToCache = response.clone();
        caches.open(CACHE_VERSION).then((cache) => {
          cache.put(event.request, responseToCache);
        });

        return response;
      }).catch(() => {
        // Se offline e não está no cache, retorna página offline básica
        return new Response(
          '<html><body style="background:#09090b;color:#fff;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100vh;margin:0;"><div style="text-align:center;"><h1>Offline</h1><p>Você está offline. Conecte-se para acessar este conteúdo.</p></div></body></html>',
          {
            headers: { 'Content-Type': 'text/html' }
          }
        );
      });
    })
  );
});

