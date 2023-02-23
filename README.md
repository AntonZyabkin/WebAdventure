# WebAdventure
 - Архитектура: MVP + moduleBuilder
 - Сетево слой: Moya
 - Хранение: SwiftKeychainWrapper
 - Декодер: JSONDecoder
 - Верстка: NSLayoutConstraint
 - API: https://api-events.pfdo.ru/v1


Особенности:
- изменен порядок ВЬюКОнтроллеров: сначала показываем основной, при необходимости показываем контроллер аутентификации, чтобы постоянно его в памяти не держать во время активной сессии
- Особенность API: при вызове метода POST https://api-events.pfdo.ru/v1/auth в случае уcпеха возвращается JSON с полем data: {some objects}, в кодах отличных от 200 возвращается data: []. Поэтому сообщения ошибки не выводятся
