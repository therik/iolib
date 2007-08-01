;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Indent-tabs-mode: NIL -*-
;;;
;;; package.lisp --- Package definition.
;;;
;;; Copyright (C) 2006-2007, Stelian Ionescu  <sionescu@common-lisp.net>
;;;
;;; This code is free software; you can redistribute it and/or
;;; modify it under the terms of the version 2.1 of
;;; the GNU Lesser General Public License as published by
;;; the Free Software Foundation, as clarified by the
;;; preamble found here:
;;;     http://opensource.franz.com/preamble.html
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General
;;; Public License along with this library; if not, write to the
;;; Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
;;; Boston, MA 02110-1301, USA

(in-package :common-lisp-user)

(defpackage :io.streams
  (:use #:common-lisp :cffi :alexandria :trivial-gray-streams)
  (:export
   #:ub8 #:ub16 #:ub32 #:sb8 #:sb16 #:sb32
   #:ub8-sarray #:ub8-vector #:ub16-sarray
   #:external-format-of
   #:fd-mixin
   #:dual-channel-fd-mixin
   #:dual-channel-single-fd-mixin
   #:input-fd #:input-fd-of #:input-fd-non-blocking
   #:output-fd #:output-fd-of #:output-fd-non-blocking
   #:fd-of #:fd-non-blocking
   #:dual-channel-gray-stream))
