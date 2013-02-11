(define (zone-place-tag z) (car z))
(define (zone-x z) (cadr z))
(define (zone-y z) (caddr z))
(define (zone-w z) (cadddr z))
(define (zone-h z) (list-ref z 4))

;; Gregor's Hut
(define (mk-zone x y w h) (list 'p_gregors_hut x y w h))
(define gh-all             (mk-zone 0  0  32 32))
(define gh-living-room     (mk-zone 10 16 7  4))
(define gh-ilyas-room      (mk-zone 7  18 2  2))
(define gh-ilyas-bed       (mk-zone 7  18 1  1))
(define gh-gregors-room    (mk-zone 7  15 2  2))
(define gh-gregors-bed     (mk-zone 7  16 1  1))
(define gh-kitchen         (mk-zone 10 10 7  5))
(define gh-storeroom       (mk-zone 18 10 2  5))
(define gh-stable          (mk-zone 18 16 2  4))
(define gh-pasture         (mk-zone 21 10 5  10))
(define gh-graveyard       (mk-zone 29 29 3  3))
(define gh-table-1         (mk-zone 13 11 1  1))
(define gh-table-2         (mk-zone 13 13 1  1))

;; Moongate clearing
(define (mk-zone x y w h) (list 'p_moongate_clearing x y w h))
(define mgc-roadbend  (mk-zone 10 20 3 3))
(define mgc-cave      (mk-zone  1 23 6 3))

;; Enchanter's Tower
(define (mk-zone x y w h) (list 'p_enchanters_tower x y w h))
(define enchtwr-campsite         (mk-zone  5  5  3   3))
(define enchtwr-dining-room-1    (mk-zone  9 11  1   1))
(define enchtwr-dining-room-2    (mk-zone 11 11  1   1))
(define enchtwr-dining-room      (mk-zone  8  8  5   5))
(define enchtwr-bedroom-1        (mk-zone 18 11  5   2))
(define enchtwr-hall             (mk-zone 11 18  9   6))
(define enchtwr-ench-bed         (mk-zone 21 11  1   1))
(define enchtwr-zane-bed         (mk-zone  7  6  1   1))

;; Bole
(define (mk-zone x y w h) (list 'p_bole x y w h))
(define bole-bed-kathryn  (mk-zone 31 21  1  1))
(define bole-bedroom-thud (mk-zone 31 20  2  2))
(define bole-bed-2        (mk-zone 38 18  1  1))
(define bole-bed-3        (mk-zone 31 21  1  1))
(define bole-bed-4        (mk-zone 38 21  1  1))
(define bole-bed-may      (mk-zone 44 17  1  1))
(define bole-bed-melvin   (mk-zone 40 17  1  1))
(define bole-bed-bill     (mk-zone 23 19  1  1))
(define bole-bed-hackle   (mk-zone 5  8   1  1))
(define bole-bedroom-may  (mk-zone 40 18  5  4))
(define bole-bills-hut    (mk-zone 20 15  4  5))
(define bole-courtyard    (mk-zone 24 25  5  5))
(define bole-dining-hall  (mk-zone 31 23  5  7))
(define bole-hackles-hut  (mk-zone 5   8  5  5))
(define bole-hackles-yard (mk-zone 2   3  5 13))
(define bole-kitchen      (mk-zone 39 23  3  7))
(define bole-n-woods      (mk-zone 22  0  8 11))
(define bole-table-1      (mk-zone 32 26  1  1))
(define bole-table-2      (mk-zone 34 26  1  1))
(define bole-table-3      (mk-zone 34 27  1  1))
(define bole-table-4      (mk-zone 32 27  1  1))

;; Trigrave
(define (mk-zone x y w h) (list 'p_trigrave x y w h))
(define trigrave-chants-bed      (mk-zone 12  6   1  1))
(define trigrave-forge           (mk-zone 25  4   5  5))
(define trigrave-jims-bed        (mk-zone 25 10   1  1))
(define trigrave-tavern-hall     (mk-zone 18 23   8  6))
(define trigrave-tavern-kitchen  (mk-zone 27 25   3  5))
(define trigrave-miggs-bed       (mk-zone 27 22   1  1))
(define trigrave-tavern-table-1a (mk-zone 19 23   1  1)) 
(define trigrave-tavern-table-1d (mk-zone 21 23   1  1)) 
(define trigrave-tavern-table-3a (mk-zone 19 27   1  1)) 
(define trigrave-tavern-table-3b (mk-zone 21 27   1  1)) 
(define trigrave-inn-counter     (mk-zone  5  4   9  3))
(define trigrave-gwens-bed       (mk-zone 12  2   1  1))
(define trigrave-gwens-room      (mk-zone 11  2   2  3))
(define trigrave-inn-room-1      (mk-zone  2  6   2  2))
(define trigrave-inn-room-2      (mk-zone  2  9   2  2))
(define trigrave-inn-room-3      (mk-zone 11  6   2  2))
(define trigrave-inn-room-4      (mk-zone 11  9   2  2))
(define trigrave-east-west-road  (mk-zone  0 15  32  3))
(define trigrave-earls-bed       (mk-zone  2  9   1  1))
(define trigrave-earls-counter   (mk-zone  2 24   5  1))
(define trigrave-earls-room      (mk-zone  2  9   2  2))

;; Oparine
(define (mk-zone x y w h) (list 'p_oparine x y w h))
(define alkemist-shop    (mk-zone  3 28 4 3))
(define alkemist-bed     (mk-zone  5 22 1 1))
(define alkemist-bedroom (mk-zone  5 22 3 3))
(define bilge-water-counter    (mk-zone 21  4  5  1))
(define bilge-water-storage    (mk-zone 19  2  1  3))
(define bilge-water-bedroom    (mk-zone 27  2  2  3))
(define bilge-water-bed        (mk-zone 27  2  1  1))
(define bilge-water-hall       (mk-zone 22  6  3  7))
(define bilge-water-seat-1     (mk-zone 19  7  1  1))
(define bilge-water-seat-2     (mk-zone 20  7  1  1))
(define bilge-water-seat-3     (mk-zone 21  7  1  1))
(define bilge-water-seat-4     (mk-zone 19  9  1  1))
(define bilge-water-seat-5     (mk-zone 20  9  1  1))
(define bilge-water-seat-6     (mk-zone 21  9  1  1))
(define bilge-water-seat-7     (mk-zone 10 10  1  1))
(define bilge-water-seat-8     (mk-zone 20 10  1  1))
(define bilge-water-seat-9     (mk-zone 21 10  1  1))
(define bilge-water-seat-10    (mk-zone 19 11  1  1))
(define bilge-water-seat-11    (mk-zone 20 11  1  1))
(define bilge-water-seat-12    (mk-zone 21 11  1  1))
(define bilge-water-seat-13    (mk-zone 25  7  1  1))
(define bilge-water-seat-14    (mk-zone 26  7  1  1))
(define bilge-water-seat-15    (mk-zone 27  7  1  1))
(define bilge-water-seat-16    (mk-zone 25  9  1  1))
(define bilge-water-seat-17    (mk-zone 26  9  1  1))
(define bilge-water-seat-18    (mk-zone 27  9  1  1))
(define bilge-water-seat-19    (mk-zone 25 10  1  1))
(define bilge-water-seat-20    (mk-zone 26 10  1  1))
(define bilge-water-seat-21    (mk-zone 27 10  1  1))
(define bilge-water-seat-22    (mk-zone 25 11  1  1))
(define bilge-water-seat-23    (mk-zone 26 11  1  1))
(define bilge-water-seat-24    (mk-zone 27 11  1  1))
(define sea-witch-shop    (mk-zone  2 40  5  2))
(define sea-witch-counter (mk-zone  3 43  3  1))
(define sea-witch-broom   (mk-zone  3 45  3  2))
(define sea-witch-beach   (mk-zone  3 49  3  1))
(define sea-witch-bay     (mk-zone  2 52  5  3))
(define sea-witch-bed     (mk-zone  3 45  1  1))
(define sea-witch-shore   (mk-zone  3 50  3  1))
(define cheerful-counter  (mk-zone 3 4  8  1))
(define cheerful-room-1   (mk-zone 3 9 2  2))
(define cheerful-room-2   (mk-zone 3 12 2  2))
(define cheerful-room-3   (mk-zone 6 15 2  2))
(define cheerful-room-4   (mk-zone 9 9 2  2))
(define cheerful-room-5   (mk-zone 9 12 2  2))
(define cheerful-bed-1   (mk-zone 3 4  1  1))
(define cheerful-bed-2   (mk-zone 3 9  1  1))
(define cheerful-bed-3   (mk-zone 6 15  1  1))
(define cheerful-bed-4   (mk-zone 10 9  1  1))
(define cheerful-bed-5   (mk-zone 10 12  1  1))
(define oparine-innkeepers-hut   (mk-zone  3 15 2 2))
(define oparine-innkeepers-bed   (mk-zone  4 15 1 1))
(define black-barts-ship  (mk-zone 24 26  5  6))
(define black-barts-broom (mk-zone 15 28  2  2))
(define black-barts-bed   (mk-zone 15 28  1  1))

;;----------------------------------------------------------------------------
;; Glasdrin
(define (mk-zone x y w h) (list 'p_glasdrin x y w h))

;; hospital
(define gh-ward (mk-zone 20 5 6 4))

;; citadel
(define gc-hall (mk-zone 12 4 7 7))
(define gc-train (mk-zone 10 23 3 3))

;; axe-n-shielf
(define gas-counter (mk-zone 6 5 5 1))

;; holy grail
(define ghg-counter (mk-zone 23 26 3 1))
(define ghg-s1 (mk-zone 24 21 1 1))
(define ghg-s2 (mk-zone 25 22 1 1))
(define ghg-s3 (mk-zone 25 23 1 1))
(define ghg-s4 (mk-zone 24 24 1 1))
(define ghg-s5 (mk-zone 23 23 1 1))
(define ghg-s6 (mk-zone 23 22 1 1))
(define ghg-hall (mk-zone 22 20 5 5))

;; doc patch's hut
(define gdp-hut (mk-zone 25 10 2 2))
(define gdp-bed (mk-zone 26 10 1 1))

;; palisade inn
(define gpi-counter (mk-zone 4 19 5 1))

;; beds
(define ga-bed (mk-zone  4 13 1 1))
(define gj-bed (mk-zone 26 13 1 1))
(define gc-bed (mk-zone  4 10 1 1))
(define gv-bed (mk-zone 11 14 1 1))
(define gi-bed (mk-zone 29 28 1 1))
(define gcj-bed (mk-zone 19 14 1 1))
(define gjan-bed (mk-zone 1 29 1 1))

;; fountain
(define g-fountain (mk-zone 14 16 3 3))
(define gs-altar (mk-zone 27 1 3 3))

;;----------------------------------------------------------------------------
;; Prison ('neath Glasdrin)
(define (mk-zone x y w h) (list 'p_engineers_hut x y w h))
(define prison-hall (mk-zone 7 2 5 5))

;;----------------------------------------------------------------------------
;; Engineer's Hut
(define (mk-zone x y w h) (list 'p_engineers_hut x y w h))
(define eng-bed (mk-zone 16 15 1 1))
(define eng-workshop (mk-zone 3 3 6 9))

;;----------------------------------------------------------------------------
;; The MAN's Hideout
(define (mk-zone x y w h) (list 'p_mans_hideout x y w h))
(define mans-bed (mk-zone 3 3 1 1))
(define mans-supper (mk-zone 4 15 1 1))
(define mans-hall (mk-zone 7 6 5 7))
(define mans-tools (mk-zone 14 2 3 3))
(define mans-dock (mk-zone 15 13 1 1))

;;----------------------------------------------------------------------------
;; Poor House
(define (mk-zone x y w h) (list 'p_poor_house x y w h))
(define poorh-hall (mk-zone 4 6 5 3))
(define poorh-dining (mk-zone 10 7 5 7))
(define poorh-pasture (mk-zone 11 1 7 5))
(define poorh-bunkroom (mk-zone 5 10 3 5))
(define poorh-bed1 (mk-zone 4 10 1 1))
(define poorh-bed2 (mk-zone 4 12 1 1))
(define poorh-bed3 (mk-zone 4 14 1 1))
(define poorh-bed4 (mk-zone 8 10 1 1))
(define poorh-bed5 (mk-zone 8 12 1 1))
(define poorh-bed6 (mk-zone 8 14 1 1))
(define poorh-sup1 (mk-zone 12 8 1 1))
(define poorh-sup2 (mk-zone 13 9 1 1))
(define poorh-sup3 (mk-zone 13 10 1 1))
(define poorh-sup4 (mk-zone 13 11 1 1))
(define poorh-sup5 (mk-zone 12 12 1 1))
(define poorh-sup6 (mk-zone 11 11 1 1))
(define poorh-sup7 (mk-zone 11 10 1 1))
(define poorh-sup8 (mk-zone 11 9  1 1))

;;----------------------------------------------------------------------------
;; Green Tower (incomplete)
(define (mk-zone x y w h) (list 'p_green_tower x y w h))
(define gt-ws-hall (mk-zone 46 50 12 8))
(define gt-ws-tbl1 (mk-zone 47 52 1 1))
(define gt-ws-tbl2 (mk-zone 49 53 1 1))
(define gt-jorn-bed (mk-zone 20 57 1 1))
(define gt-jorn-hut (mk-zone 21 57 4 4))
(define gt-abe-bed (mk-zone 3 3 1 1))
(define gt-ruins (mk-zone 6 50 7 7))
(define doris-bed (mk-zone 58 61 1 1))
(define abigail-bed (mk-zone 60 61 1 1))
(define white-stag-counter (mk-zone 47 59 10 1))
(define gt-woods (mk-zone 7 20 5 5))
(define gt-tower (mk-zone 30 30 5 5))

;;----------------------------------------------------------------------------
;; Green Tower Lower (incomplete)
(define (mk-zone x y w h) (list 'p_green_tower_lower x y w h))
(define gtl-cell1 (mk-zone 8 1 2 3))
(define gtl-jailor-bed (mk-zone 1 14 1 1))
(define gtl-jail (mk-zone 1 1 10 14))

;;----------------------------------------------------------------------------
;; Necromancer's Lair
(define (mk-zone x y w h) (list 'p_necromancers_lair x y w h))
(define nl-bed (mk-zone 15 3 1 1))
(define nl-lab (mk-zone 3 15 3 4))
(define nl-tbl (mk-zone 9 2 1 1))
(define nl-lib (mk-zone 15 13 3 4))

;;----------------------------------------------------------------------------
;; Old Absalot
(define (mk-zone x y w h) (list 'p_old_absalot x y w h))
(define oa-bed1 (mk-zone 4 8 1 1))
(define oa-tbl1 (mk-zone 25 17 1 1))
(define oa-tbl2 (mk-zone 27 17 1 1))
(define oa-tbl3 (mk-zone 26 19 1 1))
(define oa-altar (mk-zone 10 2 6 3))
(define oa-baths (mk-zone 25 23 5 7))
(define oa-temple (mk-zone 10 5 6 6))
(define oa-bed2 (mk-zone 21 1 1 1))
(define oa-bed3 (mk-zone 23 1 1 1))
(define oa-bed4 (mk-zone 23 3 1 1))
(define oa-bed5 (mk-zone 23 5 1 1))
(define oa-slaves (mk-zone 1 12 6 7))
(define oa-dining-hall (mk-zone 23 13 7 8))

;;----------------------------------------------------------------------------
;; Entrance to Kurpolis
(define (mk-zone x y w h) (list 'p_kurpolis_entrance x y w h))
(define ke-bed1 (mk-zone  5 17  1  1))
(define ke-bed2 (mk-zone  7 17  1  1))
(define ke-hall (mk-zone  1  9  3  3))
(define ke-dine (mk-zone  5  1  9  5))
(define ke-tbl1 (mk-zone  9  2  1  1))
(define ke-tbl2 (mk-zone  9  4  1  1))
(define ke-bunk (mk-zone  5 14  9  5))

;;----------------------------------------------------------------------------
;; Paladin's Hold
(define (mk-zone x y w h) (list 'p_paladins_hold x y w h))
(define ph-bed1 (mk-zone 13 17  1  1))
(define ph-bed2 (mk-zone 15 17  1  1))
(define ph-bed3 (mk-zone 17 17  1  1))
(define ph-hall (mk-zone  4  7  5  5))
(define ph-dine (mk-zone 10  1  9  5))
(define ph-tbl1 (mk-zone 13  2  1  1))
(define ph-tbl2 (mk-zone 13  4  1  1))
(define ph-tbl3 (mk-zone 16  3  1  1))
(define ph-medik (mk-zone 13 14 5  4))
(define ph-arms (mk-zone   1 14 4  4))

;;----------------------------------------------------------------------------
;; Kun
(define (mk-zone x y w h) (list 'p_kun x y w h))
(define cantina-counter (mk-zone 4 5 3 1))
(define cantina-counter-zzz (mk-zone 5 5 1 1))
(define cantina (mk-zone 1 2 9 7))
(define cantina-1 (mk-zone 3 3 1 1))
(define cantina-2 (mk-zone 4 3 1 1))
(define cantina-3 (mk-zone 5 3 1 1))
(define cantina-4 (mk-zone 6 3 1 1))
(define cantina-5 (mk-zone 7 3 1 1))
(define cantina-6 (mk-zone 8 4 1 1))
(define cantina-7 (mk-zone 8 5 1 1))
(define cantina-8 (mk-zone 8 6 1 1))
(define cantina-9 (mk-zone 3 7 1 1))
(define cantina-10 (mk-zone 4 7 1 1))
(define cantina-11 (mk-zone 5 7 1 1))
(define cantina-12 (mk-zone 6 7 1 1))
(define cantina-13 (mk-zone 7 7 1 1))
(define cantina-14 (mk-zone 2 6 1 1))
(define cantina-15 (mk-zone 2 5 1 1))
(define cantina-16 (mk-zone 2 4 1 1))
(define black-market (mk-zone 9 14 9 3))
(define black-market-counter (mk-zone 9 16 9 3))
(define campfire-1 (mk-zone 1 14 1 1))
(define campfire-2 (mk-zone 2 13 1 1))
(define campfire-3 (mk-zone 2 15 1 1))
(define campfire-4 (mk-zone 3 14 1 1))
(define kun-road (mk-zone 12 1 3 10))